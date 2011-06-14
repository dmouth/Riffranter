class Persona < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 50

  validates :name, :presence => true, :uniqueness => true
  validates :title, :presence => true
  
  has_many :rants
  has_and_belongs_to_many :following_users, :class_name => "User", :join_table => :personas_users
  has_and_belongs_to_many :categories, :order => :name

  mount_uploader :image, ImageUploader
  
  def following_users_for_mail
    following_users.where(:send_mail_updates >> true)
  end
end


# == Schema Information
#
# Table name: personas
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  title      :string(255)
#  image      :text
#  created_at :datetime
#  updated_at :datetime
#

