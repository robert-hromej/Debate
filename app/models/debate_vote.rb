class DebateVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :debate_question

end
