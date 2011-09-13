class DebateVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :debate_question

  after_save :recounting

  validates_presence_of :user_id, :debate_question_id
  validates :current_vote, :inclusion => [-1,0,1]

  def recounting
    debate_question.recounting
  end

end
