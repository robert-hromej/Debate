class User < ActiveRecord::Base

  has_many :debate_votes
  has_many :debate_questions
  has_many :comments
  has_many :comment_votes

end
