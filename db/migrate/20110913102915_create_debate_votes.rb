class CreateDebateVotes < ActiveRecord::Migration
  def self.up
    create_table :debate_votes do |t|
      t.integer :user_id, :null => false
      t.integer :debate_question_id, :null => false
      t.integer :current_vote, :null => false

      t.timestamps
    end
    add_index :debate_votes, [:user_id, :debate_question_id], :unique => true
  end

  def self.down
    drop_table :debate_votes
  end
end
