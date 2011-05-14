class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :admin
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password, :presence => true, :on => :create

  validates :email, :presence => true, :uniqueness => true
  validates_confirmation_of :password
  
  has_many :rants
  has_many :followed_personas, :order => :name
  
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
end
# == Schema Information
#
# Table name: users
#
#  id            :integer(4)      not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  admin         :boolean(1)
#

