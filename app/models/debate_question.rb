class DebateQuestion < ActiveRecord::Base

  belongs_to :user
  has_many :debate_votes
  has_many :comments

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

  def recounting
    result = DebateVote.sub_query(uniq_votes).count(:id, :group => :current_vote)
    self.update_attributes(:yes_count => result[DebateVote::YES] || 0,
                           :no_count => result[DebateVote::NO] || 0,
                           :neutral_count => result[DebateVote::NEUTRAL] || 0)
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

