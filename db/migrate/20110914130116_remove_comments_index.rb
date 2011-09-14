class RemoveCommentsIndex < ActiveRecord::Migration
  def self.up
    remove_index :comments, [:user_id, :debate_question_id]
  end

  def self.down
    add_index :comments, [:user_id, :debate_question_id], :unique => true
  end
end
