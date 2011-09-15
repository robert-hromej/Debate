class DebateVote < ActiveRecord::Base

  NO = -1
  NEUTRAL = 0
  YES = 1

  belongs_to :user
  belongs_to :debate_question

  after_save :recounting

  validates_presence_of :user_id, :debate_question_id
  validates :current_vote, :inclusion => [-1, 0, 1]
  validates_uniqueness_of :user_id, :scope => :debate_question_id

  def recounting
    debate_question.recounting
  end

  def vote?(vote)
    case vote
      when :yes
        yes?
      when :no
        no?
      when :neutral
        neutral?
    end
  end

  def yes?
    self.current_vote == YES
  end

  def no?
    self.current_vote == NO
  end

  def neutral?
    self.current_vote == NEUTRAL
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

