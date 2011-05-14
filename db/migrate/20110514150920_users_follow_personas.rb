class UsersFollowPersonas < ActiveRecord::Migration
  def self.up
    create_table :personas_users, :force => true, :id => false do |t|
      t.references :user
      t.references :persona 
    end
    add_index :persona, [:persona_id, :user_id]
  end

  def self.down
    remove_index :persona, [:persona_id, :user_id]
    drop_table :personas_users
  end
end