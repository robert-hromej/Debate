class DebateQuestion < ActiveRecord::Base

  belongs_to :user
  has_many :debate_votes
  has_many :comments

  has_many :debate_yes_votes, :class_name => "DebateVote", :conditions => {:current_vote => 1}
  has_many :debate_no_votes, :class_name => "DebateVote", :conditions => {:current_vote => -1}
  has_many :debate_neutral_votes, :class_name => "DebateVote", :conditions => {:current_vote => 0}

  attr_accessible :body, :yes_count, :no_count, :neutral_count, :user_id

  validates :body, :presence => true, :length => {:within => 3..256}
  validates :user_id, :presence => true

  scope :top_debates, select("(yes_count + no_count  + neutral_count) as votes, debate_questions.*").order("votes DESC").limit(5)
  scope :recent_debates, order("created_at DESC").limit(5)

  def recounting
    self.update_attributes(:yes_count => self.debate_yes_votes.count,
                           :no_count => self.debate_no_votes.count,
                           :neutral_count => self.debate_neutral_votes.count)
  end
  
end
