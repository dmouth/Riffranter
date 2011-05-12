class CreateRants < ActiveRecord::Migration
  def self.up
    create_table :rants do |t|
      t.integer :user_id
      t.integer :persona_id
      t.text :body
      t.string :ip
      t.timestamps
    end           
    add_index :rants, :user_id
    add_index :rants, :persona_id
  end

  def self.down
    remove_index :rants, :persona_id
    remove_index :rants, :user_id
    drop_table :rants
  end
end