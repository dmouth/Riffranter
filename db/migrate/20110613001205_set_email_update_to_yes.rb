class SetEmailUpdateToYes < ActiveRecord::Migration
  def self.up
    for user in User.all
      user.send_mail_updates = true
      user.save
    end
  end

  def self.down
  end
end
