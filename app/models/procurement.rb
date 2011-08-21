class Procurement

  attr_accessor :vendor_code, :purchaseorder_id, :sku, :date

  def initialize(vendor_code, purchaseorder_id, sku, date)
    @vendor_code, @purchaseorder_id, @sku, @date = vendor_code, purchaseorder_id, sku, date
  end


# Method to process the row from procurement data
  # Expected columns:
  #  vendor
  #  purchaseorder
  #  asin
  #  data
  def process
    vendor = Vendor.find_by_code(self.vendor_code)
    return unless vendor
    purchaseorder = Purchaseorder.search(self.purchaseorder_id, vendor.id)
    purchaseorder = vendor.purchaseorders.create!(
        :code => self.purchaseorder_id,
        :condition=>'incomplete',
        :delivery_date=>Date.parse(self.date).to_time,
        :marketplace=>'EU',
        :status=>'pending_vendor_input'
    ) unless purchaseorder

    asin = Asin.search(self.sku, purchaseorder.id)

    asin = purchaseorder.asins.create!(
        :sku => self.sku,
        :title => 'Missing Title',
        :srq_impact_source => 'default',
        :status=>'pending_vendor_input'
    ) unless asin

  end

end