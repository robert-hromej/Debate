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

  def uniq_votes
    DebateVote.uniq_votes.where(:debate_question_id => self.id)
  end

  def vote?(user_id)
    if user_vote(user_id)
      @user_vote.vote
    else
      nil
    end
  end

  def user_vote(user_id)
    @user_vote ||= debate_votes.where(:user_id => user_id).last
  end

  def analytics_data
    result = analytics_vote_count
    analytics_data_hash = {}
    [:yes, :no, :neutral].each do |vote|
      analytics_data_hash[vote] = result[vote] unless result[vote].empty?
    end

    analytics_data_hash
  end

  def recounting
    result = DebateVote.sub_query(uniq_votes).count(:id, :group => :current_vote)
    self.update_attributes(:yes_count => result[DebateVote::YES] || 0,
                           :no_count => result[DebateVote::NO] || 0,
                           :neutral_count => result[DebateVote::NEUTRAL] || 0)
  end

  def winner
    max_vote = [yes_count, no_count, neutral_count].max
    case max_vote
      when yes_count
        "positive"
      when no_count
        "negative"
      when neutral_count
        "neutral"
    end
  end

  private

  def analytics_vote_count
    data_array = {:yes => [], :no => [], :neutral => []}

    DebateVote.sub_query(uniq_votes).select(" UNIX_TIMESTAMP(DATE(debate_votes.created_at))*1000 as date,
                                              count(debate_votes.current_vote) as count_by_day,
                                              debate_votes.current_vote").
        group("DATE(debate_votes.created_at), debate_votes.current_vote").each do |data|

      count = [data.date.to_i, data.count_by_day.to_i]

      case data.current_vote.to_i
        when -1
          data_array[:no] << count
        when 0
          data_array[:neutral] << count
        when 1
          data_array[:yes] << count
      end
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

