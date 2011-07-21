class Asin < ActiveRecord::Base

  # Status - pending_vendor_input, vendor_input_complete, compliance_approved
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

  scope :by_compliance, lambda { |compliance|
    {
     :conditions => { :compliance_id => compliance.id }
    }
  }

  def compliance_approved
    self.status = "compliance_approved"
    self.save
    self.purchaseorder.compliance_approved
  end

  def compliance_rejected
    self.compliance_id = nil
    self.status = "pending_vendor_input"
    self.save
  end

end

