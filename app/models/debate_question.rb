class DebateQuestion < ActiveRecord::Base

  belongs_to :user
  has_many :debate_votes
  has_many :comments

  attr_accessible :body, :yes_count, :no_count, :neutral_count

  validates :body, :presence => true, :length => 256
  validates :user_id, :presence => true
end
