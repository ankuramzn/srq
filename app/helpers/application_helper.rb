module ApplicationHelper
  def css(count)
    (count%2 == 0)? "zebra2" : "zebra1"
  end

  def pending_vendor_input(asin)
   if asin.status == "pending_vendor_input"
     true
   else
     false
   end
  end

  # The set of statuses that can be assigned to a Compliance Set
  def compliance_set_status
    %w[vendor pc approved rejected]
  end
end
