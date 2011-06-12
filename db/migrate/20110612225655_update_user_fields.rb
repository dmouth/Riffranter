class UpdateUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :handle, :string
    add_column :users, :send_mail_updates, :boolean
    add_index :users, :handle
    add_index :users, :send_mail_updates
    
    for user in User.all
      user.handle = user.full_name.downcase.gsub(/\s/, "_")
      if !user.save
        user.handle = user.full_name.downcase.gsub(/\s/, "_") + "_1"
        user.save
      end
    end
  end

  def self.down
    remove_index :users, :send_mail_updates
    remove_index :users, :handle
    remove_column :users, :send_mail_updates
    remove_column :users, :handle
  end
end