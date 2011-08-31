module ApplicationHelper
  def css(count)
    (count%2 == 0)? "zebra2" : "zebra1"
  end

  def pending_vendor_input(asin)
    asin.status.eql?("pending_vendor_input")
  end

  # The set of statuses that can be assigned to a Compliance Set
  def compliance_set_status
    if session[:type] == "vendor"
      %w[vendor_input user_review]
    else
      %w[vendor_input user_review approved rejected]
    end
  end

  def is_compliance_deletable(compliance)
    (session[:type].eql?("vendor") and compliance.is_vendor_deletable) || (!session[:type].eql?("vendor") and compliance.is_user_deletable)
  end

  def wee_standards
    ['', 'Large household appliances', 'Small household appliances', 'IT and telecommunications equipment', 'Consumer equipment', 'Lighting equipment (Gas discharge lamps >> fluorescent and high-intensity discharge lamps)', 'Electrical and electronic tools (with the exception of large-scale stationary industrial tools)', 'Toys, leisure and sports equipment', 'Medical devices (with the exception of all implanted and infected products)', 'Monitoring and control instruments', 'Automatic dispensers']
  end

  def battery_types
    ['', 'Primary cells - Alkaline', 'Primary cells - Lithium', 'Primary cells - Lithium air', 'Primary cells - Nickel oxyhydroxide', 'Primary cells - Silver-oxide', 'Primary cells - Zinc-carbon', 'Primary cells - Zinc chloride', 'Secondary cells - Lead-acid', 'Secondary cells - Lithium air', 'Secondary cells - Lithium-ion', 'Secondary cells - Lithium iron phosphate', 'Secondary cells - Lithium-sulfur', 'Secondary cells - Lithium-titanate', 'Secondary cells - Nickel metal hydride', 'Secondary cells - Nickel-zinc', 'Secondary cells - Potassium-ion', 'Secondary cells - Rechargeable alkaline', 'Secondary cells - Silicon air', 'Secondary cells - Super iron', 'Secondary cells - Zinc matrix']
  end

  def battery_packaging_types
    ['', 'Removable', 'Built-in']
  end

  # TODO : DRY this
  def vendor_session?
    session[:type].eql?("vendor")
  end

end
