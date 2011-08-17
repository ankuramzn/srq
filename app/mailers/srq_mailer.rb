class SrqMailer < ActionMailer::Base
  default :from => User.reviewer_contact

  def vendor_status_notification(purchaseorders, vendor)
    @purchaseorders = purchaseorders
    mail(:to => vendor.contact, :subject => "Daily Status for #{vendor.name}")
  end

  def user_status_notification(purchaseorders)
    @purchaseorders = purchaseorders
    mail(:to => User.reviewer_contact, :subject => "Daily Status for Admin")
  end

  def compliance_update_notification(vendor, sku, from_status, to_status)
    @vendor, @sku, @from_status, @to_status = vendor, sku, from_status, to_status
    mail(:to => @vendor.contact, :subject => "Compliance Set Status Updated")
    mail(:to => User.reviewer_contact, :subject => "Compliance Set Status Updated")
  end
end
