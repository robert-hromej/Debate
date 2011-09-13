class Comment < ActiveRecord::Base

  has_many :comment_votes
  belongs_to :user
  belongs_to :debate_question

end
