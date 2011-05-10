class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :admin
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password, :presence => true, :on => :create

  validates :email, :presence => true, :uniqueness => true
  validates_confirmation_of :password
  
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