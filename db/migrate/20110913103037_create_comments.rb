class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id, :null => false
      t.integer :debate_question_id, :null => false
      t.integer :counter, :null => false, :default => 0
      t.string :body, :null => false
      t.integer :vote, :null => false, :default => 0

      t.timestamps
    end

    add_index :comments, [:user_id, :debate_question_id], :unique => true
  end

  def self.down
    drop_table :comments
  end
end
