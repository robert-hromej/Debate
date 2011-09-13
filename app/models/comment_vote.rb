class CommentVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :comment

  validates_presence_of :comment_id, :user_id
  
  after_create :recounting

  def recounting
    self.comment.recounting
  end

end

