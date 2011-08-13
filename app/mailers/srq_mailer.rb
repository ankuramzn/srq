class SrqMailer < ActionMailer::Base
  default :from => "aptapt402@gmail.com"

  def vendor_status_notification(purchaseorders, vendor)
    @purchaseorders = purchaseorders
    mail(:to => "aptapt402@gmail.com", :subject => "Daily Status for #{vendor}")
  end

  def user_status_notification(purchaseorders)
    @purchaseorders = purchaseorders
    mail(:to => "aptapt402@gmail.com", :subject => "Daily Status for Admin")
  end

  def compliance_update_notification(vendor, sku, from_status, to_status)
    @vendor, @sku, @from_status, @to_status = vendor, sku, from_status, to_status
    mail(:to => "aptapt402@gmail.com", :subject => "Compliance Set Status Updated")
  end
end
