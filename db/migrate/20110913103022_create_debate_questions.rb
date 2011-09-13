class CreateDebateQuestions < ActiveRecord::Migration

  def self.up
    create_table :debate_questions do |t|
      t.integer :user_id
      t.string :body, :null => false
      t.integer :yes_count, :default => 0
      t.integer :no_count, :default => 0
      t.integer :neutral_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :debate_questions
  end
end
