class AddBasicUsers < ActiveRecord::Migration
  def self.up
    User.create! do |u|
      u.first_name = "Karl"
      u.last_name = "Parker"
      u.handle = "karl_parker"
      u.email = "karl.parker.nab@gmail.com"
      u.password = "morton"
      u.password_confirmation = "morton"
      u.admin = true
    end

    User.create! do |u|
      u.first_name = "Ray"
      u.last_name = "Parker"
      u.email = "ray.parker.nab@gmail.com"
      u.handle = "ray_parker"
      u.password = "decorah"
      u.password_confirmation = "decorah"
      u.admin = true
    end

    User.create! do |u|
      u.first_name = "Regular"
      u.last_name = "User"
      u.handle = "regular_user"
      u.email = "user@example.com"
      u.password = "password"
      u.password_confirmation = "password"
      u.admin = false
    end
  end

  def self.down
  end
end
