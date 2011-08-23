class Procurement

  attr_accessor :vendor_code, :purchaseorder_id, :sku, :date, :processed_status

  def initialize(vendor_code, purchaseorder_id, sku, date)
    @vendor_code, @purchaseorder_id, @sku, @date = vendor_code, purchaseorder_id, sku, date
  end


# Method to process the row from procurement data
  # Expected columns:
  #  vendor
  #  purchaseorder
  #  asin
  #  data
  # Return Cases:
  #  Vendor Code not found in the system -> Red
  #  Vendor Code found, purchaseorder code not found in the system => Asins dont care -> Green
  #  Vendor Code found, purchaseorder code found in the system asin not found in the system -> Yellow
  #  Vendor Code found, purchaseorder code found in the system asin found in the system => existing record -> Blue

  def self.procurement_process(procurements)

    new_purchaseorders = Array.new
    procurements.each do |procurement|

      puts "Processing " + procurement.inspect
      vendor = Vendor.find_by_code(procurement.vendor_code)
      if vendor.nil?
        # Unknown vendor => no need to process this procurement
        puts "Unknown Vendor " + procurement.vendor_code
        procurement.processed_status = '#FF005D' # Red
        next
      else
        purchaseorder = Purchaseorder.search(procurement.purchaseorder_id, vendor.id)
        if purchaseorder.nil? || new_purchaseorders.include?(procurement.purchaseorder_id)
          puts "New Purchase Order " + procurement.purchaseorder_id
          # Unknown purchase order => Create both purchase order and asin
          procurement.processed_status = '#B4F263' # Green
          purchaseorder = vendor.purchaseorders.create!(
              :code => procurement.purchaseorder_id,
              :condition=>'incomplete',
              :delivery_date=>Date.parse(procurement.date).to_time,
              :marketplace=>'EU',
              :status=>'pending_vendor_input'
          ) unless purchaseorder
          new_purchaseorders << procurement.purchaseorder_id
        end


        asin = Asin.search(procurement.sku, purchaseorder.id)
        if asin.nil?
          puts "New ASIN " + procurement.sku
          procurement.processed_status = '#EDED8C' unless procurement.processed_status.eql?('#B4F263') # Yellow
          asin = purchaseorder.asins.create!(
              :sku => procurement.sku,
              :title => 'Missing Title',
              :srq_impact_source => 'default',
              :status=>'pending_vendor_input'
          )
        next
        end
        procurement.processed_status = '#B8EAF5' # Blue
      end
    end

    return procurements
  end
end