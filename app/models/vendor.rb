class Vendor < ActiveRecord::Base

  # Registration Rules
  before_save :encrypt_password
  attr_accessor :password

  validates_presence_of :code, :name, :contact, :password
  validates_confirmation_of :password
  validates_uniqueness_of :code

  # Associated Model relations
  has_many :purchaseorders, :order => 'delivery_date ASC'
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

  # Function to get Vendor's purchase Orders which contain a specific sku
  def sku_purchaseorders(sku)
    sku_purchaseorders_return = Array.new
    purchaseorders.each do |purchaseorder|
      sku_purchaseorders_return << purchaseorder unless purchaseorder.contains_sku(sku).nil?
    end
    sku_purchaseorders_return
  end

  # Function to get list of pending purchase order codes for the vendor
  def pending_purchaseorders
    pending_purchaseorders = Array.new
    purchaseorders.each do |purchaseorder|
      pending_purchaseorders << purchaseorder.code unless purchaseorder.status.eql?('compliance_approved')
    end
    pending_purchaseorders
  end
end
