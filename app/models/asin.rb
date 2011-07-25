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

  scope :unapproved, lambda {
    where("asins.status != 'compliance_approved'")
  }


  # If a Compliance Set is associated, then the vendor's 'activity for this asin is complete
  # Status is now 'vendor_input_complete' and same might apply to rolled up purchase order's status
  def compliance_associated
    self.status = "vendor_input_complete"
    self.save
    self.purchaseorder.compliance_associated
  end

  # If an associated Compliance Set is approved, then the activity for this asin is complete
  # Status is now 'compliance_approved' and same might apply to rolled up purchase order's status
  def compliance_approved
    self.status = "compliance_approved"
    self.save
    self.purchaseorder.compliance_approved
  end

  # If an associated Compliance Set is rejected, then a new Compliance set with be needed
  # Status is now back to 'pending_vendor_input' and same applies to the rolled up purchase order's status
  def compliance_rejected
    self.compliance_id = nil
    self.status = "pending_vendor_input"
    self.purchaseorder.status = "pending_vendor_input"
    self.save
  end

  def approved?
    self.status.eql?("compliance_approved")
  end

end

