class Comment < ActiveRecord::Base

  has_many :comment_votes
  belongs_to :user
  belongs_to :debate_question

  def recounting
    self.update_attribute(:counter, self.comment_votes.count)
  end

end
