class Vendor < ActiveRecord::Base

  # Registration Rules
  before_save :encrypt_password
  attr_accessor :password

  validates_presence_of :code, :name, :contact, :password
  validates_confirmation_of :password
  validates_uniqueness_of :code, :contact

  # Associated Model relations
  has_many :purchaseorders
  has_many :compliances
  has_many :asins, :through => :purchaseorders

  # Function to encrypt the submitted password prior to storing
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  #  Function to authenticate Vendor
  def self.authenticate(code, password)
    vendor = Vendor.find_by_code(code)
    if vendor and vendor.password_hash == BCrypt::Engine.hash_secret(password, vendor.password_salt)
      return vendor
    else
      return nil
    end
  end


end
