class Purchaseorder < ActiveRecord::Base

  # Status - incomplete, compliance_approved
  belongs_to :vendor
  has_many :asins

  def contains_sku(sku)
    asins.each do |asin|
      if sku == asin.sku
        return self
      end
    end
    return nil
  end

  def compliance_approved
    approve = true
    self.asins.each do |asin|
      approve = approve and asin.status.eql?("compliance_approved")
    end
    self.status = "compliance_approved" if approve
    self.save
  end

  def self.contains_sku(sku)
    purchaseorders = Array.new
    asins = Asin.by_sku(sku)
    asins.each do |asin|
      purchaseorders << asin.purchaseorder unless purchaseorders.include?(asin.purchaseorder)
    end
    return purchaseorders
  end

end
