class DebateQuestion < ActiveRecord::Base

  belongs_to :user
  has_many :debate_votes
  has_many :comments


end
