class CommentVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :comment

  after_create :recounting

  def recounting
    self.comment.recounting
  end

end

