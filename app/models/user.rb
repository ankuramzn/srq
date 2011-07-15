class User < ActiveRecord::Base

  #rails g model user username:string password_hash:string password_salt:string type:string

  attr_accessible :username, :password, :password_confirmation, :user_type
  attr_accessor :password


  validates_presence_of :username
  validates_uniqueness_of :username

  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    if user and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

end


