class DebateVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :debate_question

  after_save :recounting

  validates_presence_of :user_id, :debate_question_id
  validates :current_vote, :inclusion => [-1,0,1]

  def recounting
    debate_question.recounting
  end

end

# == Schema Information
#
# Table name: debate_votes
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)      not null
#  debate_question_id :integer(4)      not null
#  current_vote       :integer(4)      not null
#  created_at         :datetime
#  updated_at         :datetime
#

