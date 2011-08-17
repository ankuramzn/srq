require 'aws/s3'

namespace :srq do

  desc "Script to process procurement data and add it to the application"
  task :process_procurement_data => :environment do

    unprocessed_bucket = 'procurement-data'
    processed_bucket = 'processed-procurement-data'

    # Establish connection with S3 service
    aws_connection_instance = AmazonS3Asset.new

    # All files in bucket 'procurement-data' are unprocessed
    unprocessed_po_files =  aws_connection_instance.bucket_keys(unprocessed_bucket)

    # Iterate over all unprocessed files => retrieve, process and add the Procurement Data to application
    unprocessed_po_files.each do |po_file|

      # Retrieve
      s3_file_object = aws_connection_instance.bucket_object(unprocessed_bucket, po_file)

      # Parse and add to application
      FasterCSV.parse(s3_file_object.value, :headers => true, :col_sep => " ") do |row|
        process_row(row)
        #puts row.to_hash.inspect
      end

      # Cleanup file and move to 'processed-procurement-data' bucket
      aws_connection_instance.store_object(processed_bucket, s3_file_object.key, s3_file_object.value)

      aws_connection_instance.delete_key(unprocessed_bucket, s3_file_object.key)

    end
  end

  # Method to process the row from procurement data
  # Expected columns:
  #  vendor
  #  purchaseorder
  #  asin
  def process_row(row)
    puts row.to_hash.inspect
    row_hash = row.to_hash
    vendor = Vendor.find_by_code(row_hash["vendor"])
    return unless !vendor.nil?
    purchaseorder = Purchaseorder.search(row_hash["purchaseorder"], vendor.id)

    purchaseorder = vendor.purchaseorders.create!(
        :code => row_hash["purchaseorder"],
        :condition=>'incomplete',
        :delivery_date=>Time.now,
        :marketplace=>'US',
        :status=>'pending_vendor_input'
    ) unless !purchaseorder.nil?

    asin = Asin.search(row_hash["asin"], purchaseorder.id)

    asin = purchaseorder.asins.create!(
        :sku => row_hash["asin"],
        :title => 'Missing Title',
        :srq_impact_source => 'default',
        :status=>'pending_vendor_input'
    ) unless !asin.nil? #TODO: Check if same ASIN can occur on same Purchase Order as a valid case

  end

  desc "Task to send status notifications about open purchase orders to each vendor and user"
  task :status_notification => :environment do
    all_pending_purchaseorders = Array.new

    # Iterate over each Vendor and generate notification for them if any pending purchaseorders are found
    Vendor.all.each do |vendor|
      vendor_pending_purchaseorders = vendor.pending_purchaseorders
      SrqMailer.vendor_status_notification(vendor_pending_purchaseorders, vendor).deliver unless vendor_pending_purchaseorders.empty?
      all_pending_purchaseorders =  all_pending_purchaseorders + vendor_pending_purchaseorders
    end

    SrqMailer.user_status_notification(all_pending_purchaseorders).deliver
  end

end