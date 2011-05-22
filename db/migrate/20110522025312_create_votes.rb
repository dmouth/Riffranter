class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :rant_id
      t.references :user
      t.integer :stars
      t.timestamps
    end                 
    add_index :votes, :rant_id
    add_index :votes, :user_id
  end

  def self.down
    remove_index :votes, :user_id
    remove_index :votes, :rant_id
    drop_table :votes
  end
end