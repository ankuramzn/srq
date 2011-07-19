class Purchaseorder < ActiveRecord::Base
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

  def self.contains_sku(sku)
    purchaseorders = Array.new
    asins = Asin.by_sku(sku)
    asins.each do |asin|
      purchaseorders << asin.purchaseorder unless purchaseorders.include?(asin.purchaseorder)
    end
    return purchaseorders
  end

end
