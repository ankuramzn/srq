class Compliance < ActiveRecord::Base

  # To prevent creation of a Compliance Set without sku and vendor
  validates :vendor_id, :presence => true
  validates :sku, :presence => true

  has_many :documents, :dependent => :delete_all
  accepts_nested_attributes_for :documents, :allow_destroy => true


  has_many :labs, :dependent => :delete_all
  accepts_nested_attributes_for :labs, :allow_destroy => true

  has_many :packaging_datas, :dependent => :delete_all
  accepts_nested_attributes_for :packaging_datas, :allow_destroy => true

  has_many :weee_product_datas, :dependent => :delete_all
  accepts_nested_attributes_for :weee_product_datas, :allow_destroy => true


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

#  TODO: FIgure out how to define association to pull up all PO ASINs linked to Compliance Set
# %w[vendor_input user_review approved rejected]

end
