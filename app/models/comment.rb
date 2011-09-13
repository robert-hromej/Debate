class Comment < ActiveRecord::Base

  has_many :comment_votes
  belongs_to :user
  belongs_to :debate_question

  validates :body, :length => {:within => 3..256}, :presence => true

  validates_presence_of :vote, :user_id, :debate_question_id
  
  def recounting
    self.update_attribute(:counter, self.comment_votes.count)
  end

end
