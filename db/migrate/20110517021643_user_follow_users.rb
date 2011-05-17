class UserFollowUsers < ActiveRecord::Migration
  def self.up
    create_table :users_users, :force => true, :id => false do |t|
      t.integer :follower_id
      t.integer :followee_id
    end     
    add_index :users_users, [:follower_id, :followee_id]
  end

  def self.down
    remove_index :users_users, [:follower_id, :followee_id]
    drop_table :users_users
  end
end