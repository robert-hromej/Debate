class CommentVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :comment

  validates_presence_of :comment_id, :user_id
  validates_uniqueness_of :comment_id, :scope => :user_id

  after_save :recounting

  def recounting
    self.comment.recounting
  end

end

# == Schema Information
#
# Table name: comment_votes
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)      not null
#  comment_id :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

