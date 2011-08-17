class Compliance < ActiveRecord::Base

  # To prevent creation of a Compliance Set without sku and vendor
  validates :vendor_id, :presence => true
  validates :sku, :presence => true

  has_many :documents, :dependent => :delete_all
  accepts_nested_attributes_for :documents, :allow_destroy => true


  has_many :labs, :dependent => :delete_all
  accepts_nested_attributes_for :labs, :allow_destroy => true

  has_many :packaging_details, :dependent => :delete_all
  accepts_nested_attributes_for :packaging_details, :allow_destroy => true

  has_many :product_details, :dependent => :delete_all
  accepts_nested_attributes_for :product_details, :allow_destroy => true

  has_many :battery_details, :dependent => :delete_all
  accepts_nested_attributes_for :battery_details, :allow_destroy => true

  belongs_to :vendor

  scope :by_vendor, lambda { |vendor|
    {
      :conditions => { :vendor_id => vendor.id }
    }
  }

  scope :by_sku, lambda { |sku|
    {
      :conditions => { :sku => sku}
    }
  }

  scope :by_status, lambda { |status|
    {
      :conditions => { :status => status}
    }
  }

  before_update :send_update_notification


  def is_vendor_editable
    status.eql?("vendor_input")
  end

  def is_user_editable
    status.eql?("user_review")
  end

  def approve
    status = "approved"
    self.save
  end

  def rejected
    status = "rejected"
    self.save
  end

  # TODO : Define the method to decide when the compliance set is expired, maybe add a expiry date on the compliance table
  def expired
  end

  def is_vendor_deletable
    is_vendor_editable
  end

  def is_user_deletable
    is_user_editable || Asin.by_compliance(self).empty?
  end

  private
  # Method to generate a notification only when the status of a Compliance Set changes
  def send_update_notification
    puts "Self Status " + self.status + " Currently persisted Status from DB " + Compliance.find(self.id).status + " => Changed " + (self.status_changed?).to_s
    SrqMailer.compliance_update_notification(self.vendor, self.sku, self.status_was, self.status).deliver unless !self.status_changed?
  end

#  TODO: Figure out how to define association to pull up all PO ASINs linked to Compliance Set
# %w[vendor_input user_review approved rejected]

end
