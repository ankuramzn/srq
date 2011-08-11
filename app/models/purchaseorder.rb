class Purchaseorder < ActiveRecord::Base

  # Status - pending_vendor_input, vendor_input_complete, compliance_approved
  belongs_to :vendor
  has_many :asins

  # Triggered as a result of a associating a compliance set with a asin on the purchase order
  # Verifying if all asins in the purchase order now have a compliance set associated (approved or not)
  def compliance_associated
    update_complete  = true
    update_approved  = true
    self.asins.each do |asin|
      update_complete = (update_complete and (  asin.status.eql?("vendor_input_complete") or asin.status.eql?("compliance_approved") ))
      update_approved = (update_approved and asin.status.eql?("compliance_approved"))
    end
    self.status = "vendor_input_complete" if update_complete
    self.status = "compliance_approved" if update_approved
    self.save
  end

  # Triggered as a result of a user approving a compliance set associated with a asin on the purchase order
  # Verifying if all asins in the purchase order now have a approved compliance set associated
  def compliance_approved
    approve = true
    self.asins.each do |asin|
      approve = approve and asin.status.eql?("compliance_approved")
    end
    self.status = "compliance_approved" if approve
    self.save
  end

  # Class level method to gather all purchase orders which contain a given sku
  def self.contains_sku(sku)
    purchaseorders = Array.new
    asins = Asin.by_sku(sku)
    asins.each do |asin|
      purchaseorders << asin.purchaseorder unless purchaseorders.include?(asin.purchaseorder)
    end
    return purchaseorders
  end

  # Object level method to check if the purchase order contains a given sku
  def contains_sku(sku)
    asins.each do |asin|
      if sku == asin.sku
        return self
      end
    end
    return nil
  end

  def self.search(code, vendor_id)
    if code and vendor_id
      find(:first, :conditions => ['code LIKE ? AND vendor_id LIKE ?', code, vendor_id])
    else
      find(:all)
    end
  end

end
