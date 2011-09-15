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
      :Yes => {
        :label => "Yes",
        :data => DebateQuestion.analytics_yes_count(self.id)
      },
      :No => {
        :label => "No",
        :data => DebateQuestion.analytics_no_count(self.id)
      },
      :Neutral => {
        :label => "Neutral",
        :data => DebateQuestion.analytics_neutral_count(self.id)
      }
    }
    analytics_data_hash
  end

  def recounting
    self.update_attributes(:yes_count => self.debate_yes_votes.count,
                           :no_count => self.debate_no_votes.count,
                           :neutral_count => self.debate_neutral_votes.count)
  end

  private

  def self.analytics_yes_count(debate_id)
    data_array = []
    select("UNIX_TIMESTAMP(DATE(debate_votes.updated_at))*1000 as date, count(debate_votes.current_vote) as yes_count_by_day").joins(:debate_votes).
    where("debate_votes.debate_question_id = ? AND debate_votes.current_vote = ?", debate_id, 1).
    group("DATE(debate_votes.updated_at)").each do |data|
      yes_array = []
      yes_array << data.date.to_i
      yes_array << data.yes_count_by_day.to_i
      data_array << yes_array
    end
    data_array
  end

  def self.analytics_no_count(debate_id)
    data_array = []
    select("UNIX_TIMESTAMP(DATE(debate_votes.updated_at))*1000 as date, count(debate_votes.current_vote) as no_count_by_day").joins(:debate_votes).
    where("debate_votes.debate_question_id = ? AND debate_votes.current_vote = ?", debate_id, -1).
    group("DATE(debate_votes.updated_at)").each do |data|
      no_array = []
      no_array << data.date.to_i
      no_array << data.no_count_by_day.to_i
      data_array << no_array
    end
    data_array
  end

  def self.analytics_neutral_count(debate_id)
    data_array = []
    select("UNIX_TIMESTAMP(DATE(debate_votes.updated_at))*1000 as date, count(debate_votes.current_vote) as neutral_count_by_day").joins(:debate_votes).
    where("debate_votes.debate_question_id = ? AND debate_votes.current_vote = ?", debate_id, 0).
    group("DATE(debate_votes.updated_at)").each do |data|
      neutral_array = []
      neutral_array << data.date.to_i
      neutral_array << data.neutral_count_by_day.to_i
      data_array << neutral_array
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

