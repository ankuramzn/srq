class Asin < ActiveRecord::Base
 belongs_to :purchaseorder
 belongs_to :compliance

  scope :by_sku, lambda { |sku|
    {
      :conditions => { :sku => sku}
    }
  }

  scope :by_vendor, lambda { |vendor|
        joins(:purchaseorder).where("purchaseorders.vendor_id = ?", vendor.id)
  }

end

