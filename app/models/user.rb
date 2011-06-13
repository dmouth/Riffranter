class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :admin, :followed_persona_ids, :followed_user_ids, :following_user_ids, :image, :send_mail_updates
  # has_friendly_id :email, :use_slug => true, :approximate_ascii => true, :max_length => 50

  mount_uploader :image, ImageUploader

  attr_accessor :password
  before_save :encrypt_password

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :handle, :presence => true, :uniqueness => true
  validates :password, :presence => true, :on => :create

  validates :email, :presence => true, :uniqueness => true
  validates_confirmation_of :password

  has_many :rants
  has_many :votes
  has_and_belongs_to_many :followed_personas, :class_name => "Persona", :join_table => :personas_users
  has_and_belongs_to_many :following_users, :join_table => "users_users", :foreign_key => "followee_id", :class_name => "User", :association_foreign_key => "follower_id"
  has_and_belongs_to_many :followed_users, :join_table => "users_users", :foreign_key => "follower_id", :class_name => "User", :association_foreign_key => "followee_id"
  
  def following_users_for_mail
    following_users.where(:send_mail_updates >> true)  
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def name
    full_name
  end

  def followed_rants limit = 5
    Rant.order(:created_at.desc).where({:persona_id.in => followed_persona_ids} | {:user_id.in => followed_user_ids}).limit(limit)
  end
end


# == Schema Information
#
# Table name: users
#
#  id                :integer(4)      not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  email             :string(255)
#  password_hash     :string(255)
#  password_salt     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  admin             :boolean(1)
#  image             :string(255)
#  handle            :string(255)
#  send_mail_updates :boolean(1)
#

