class DropUniqIndexFromDebateVotes < ActiveRecord::Migration

  def self.up
    remove_index :debate_votes, [:user_id, :debate_question_id]
  end

  def self.down
    add_index :debate_votes, [:user_id, :debate_question_id], :unique => true
  end

end
