class Compliance < ActiveRecord::Base

  # To prevent creation of a Compliance Set without sku and vendor
  validates :vendor_id, :presence => true
  validates :sku, :presence => true

  has_many :documents
  accepts_nested_attributes_for :documents, :allow_destroy => true


  has_many :labs
  accepts_nested_attributes_for :labs, :allow_destroy => true

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

#  TODO: FIgure out how to define association to pull up all PO ASINs linked to Compliance Set

end
