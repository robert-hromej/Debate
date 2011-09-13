class CreateCommentVotes < ActiveRecord::Migration
  def self.up
    create_table :comment_votes do |t|
      t.integer :user_id, :null => false
      t.integer :comment_id, :null => false

      t.timestamps
    end

    add_index :comment_votes, [:user_id, :comment_id], :unique => true
  end

  def self.down
    drop_table :comment_votes
  end
end
