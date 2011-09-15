class DebateQuestion < ActiveRecord::Base
  self.per_page = 20

  belongs_to :user
  has_many :debate_votes
  has_many :comments, :order => "created_at DESC"

  has_many :debate_yes_votes, :class_name => "DebateVote", :conditions => {:current_vote => 1}
  has_many :debate_no_votes, :class_name => "DebateVote", :conditions => {:current_vote => -1}
  has_many :debate_neutral_votes, :class_name => "DebateVote", :conditions => {:current_vote => 0}

  attr_accessible :body, :yes_count, :no_count, :neutral_count, :user_id

  validates :body, :presence => true, :length => {:within => 3..256}
  validates :user_id, :presence => true

  scope :top_debates, select("(yes_count + no_count  + neutral_count) as votes, debate_questions.*").order("votes DESC")
  scope :recent_debates, order("created_at DESC")

  def self.all_debates(sort = :top)
    case sort
      when :top
        top_debates
      when :recent
        recent_debates
      else
        recent_debates
    end
  end

  def analytics_data
    analytics_data_hash = {
      :Yes => DebateQuestion.analytics_vote_count(self.id, 1),
      :No => DebateQuestion.analytics_vote_count(self.id, -1),
      :Neutral =>  DebateQuestion.analytics_vote_count(self.id, 0),
    }

    analytics_data_hash
  end

  def recounting
    self.update_attributes(:yes_count => self.debate_yes_votes.count,
                           :no_count => self.debate_no_votes.count,
                           :neutral_count => self.debate_neutral_votes.count)
  end

  private

  def self.analytics_vote_count(debate_id, vote)
    data_array = []
    select("UNIX_TIMESTAMP(DATE(debate_votes.updated_at))*1000 as date, count(debate_votes.current_vote) as count_by_day").
    joins(:debate_votes).where("debate_votes.debate_question_id = ? AND debate_votes.current_vote = ?", debate_id, vote).
    group("DATE(debate_votes.updated_at)").each do |data|
      count_array = []
      count_array << data.date.to_i
      count_array << data.count_by_day.to_i
      data_array << count_array
    end
    data_array
  end

end

# == Schema Information
#
# Table name: debate_questions
#
#  id            :integer(4)      not null, primary key
#  user_id       :integer(4)
#  body          :string(255)     not null
#  yes_count     :integer(4)      default(0)
#  no_count      :integer(4)      default(0)
#  neutral_count :integer(4)      default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

