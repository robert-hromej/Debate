class Comment < ActiveRecord::Base
  self.per_page = 5

  has_many :comment_votes
  belongs_to :user
  belongs_to :debate_question

  validates :body, :length => {:within => 3..256}, :presence => true

  validates_presence_of :vote, :user_id, :debate_question_id

  def recounting
    self.update_attribute(:counter, self.comment_votes.count)
  end

  def vote?(user_id)
    !comment_votes.where(:user_id => user_id).first.blank?
  end

end

# == Schema Information
#
# Table name: comments
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)      not null
#  debate_question_id :integer(4)      not null
#  counter            :integer(4)      default(0), not null
#  body               :string(255)     not null
#  vote               :integer(4)      default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

