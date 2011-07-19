module ApplicationHelper
  def css(count)
    (count%2 == 0)? "zebra2" : "zebra1"
  end

  def pending_vendor_input(asin)
    asin.status.eql?("pending_vendor_input")
  end

  # The set of statuses that can be assigned to a Compliance Set
  def compliance_set_status
    %w[vendor pc approved rejected]
  end
end
