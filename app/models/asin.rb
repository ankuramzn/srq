class Asin < ActiveRecord::Base
 belongs_to :purchaseorder

  scope :by_sku, lambda { |sku|
    {
      :conditions => { :sku => sku}
    }
  }

  belongs_to :compliance

end
