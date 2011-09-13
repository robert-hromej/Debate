class DebateVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :debate_question

  after_save :recounting

  def recounting
    debate_question.recounting
  end

end
