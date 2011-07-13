# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

@vendor = Vendor.create!(
    :code=>'BEFR7',
    :contact=>'TimChen@lifungsz.com.cn',
    :is_import=>true,
    :name=>'Boni & Hanson (Li & Fung)'
)

@po = @vendor.purchaseorders.create!(
    :code => 'L7429042',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000OV0CI0',
    :title => 'B000OV0CI0 title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000UANR2I',
    :title => 'B000UANR2I title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po = @vendor.purchaseorders.create!(
    :code => 'U7650632',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000UANRIC',
    :title => 'B000UANRIC title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000UANRBO',
    :title => 'B000UANRBO title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po = @vendor.purchaseorders.create!(
    :code => 'P0132790',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000UANR50',
    :title => 'B000UANR50 title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000UAUEKG',
    :title => 'B000UAUEKG title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000OV0CI0',
    :title => 'B000OV0CI0 title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@vendor = Vendor.create!(
    :code=>'KIJT9',
    :contact=>'TimChen@lifungsz.com.cn',
    :is_import=>true,
    :name=>'Friends - Tom Douglas Only (Li & Fung)'
)

@po = @vendor.purchaseorders.create!(
    :code => 'P2088380',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B00200K1TS',
    :title => 'B00200K1TS title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@vendor = Vendor.create!(
    :code => 'EMEBI',
    :contact => 'TimChen@lifungsz.com.cn',
    :is_import => false,
    :name => 'Friends Enterprises (HK) Ltd (Li & Fung)'
)

@po = @vendor.purchaseorders.create!(
    :code => 'R3506400',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B002K6EEIQ',
    :title => 'B002K6EEIQ title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@vendor = Vendor.create!(
    :code => 'CBIK8',
    :contact => 'TimChen@lifungsz.com.cn',
    :is_import => true,
    :name => 'Good Things - Tom Douglas Only (Li & Fung)'
)

@po = @vendor.purchaseorders.create!(
    :code => 'S1059702',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000W7BHJY',
    :title => 'B000W7BHJY title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po = @vendor.purchaseorders.create!(
    :code => 'U6490212',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000W7BHJY',
    :title => 'B000W7BHJY title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po = @vendor.purchaseorders.create!(
    :code => 'U4991880',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000W7BHJY',
    :title => 'B000W7BHJY title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po = @vendor.purchaseorders.create!(
    :code => 'U7878610',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B000W7BHJY',
    :title => 'B000W7BHJY title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@vendor = Vendor.create!(
    :code => 'LECU7',
    :contact => 'TimChen@lifungsz.com.cn',
    :is_import => false,
    :name => 'Good Things - Tom Douglas Only (Li & Fung)'
)

@po = @vendor.purchaseorders.create!(
    :code => 'L3514852',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B001BR6ATG',
    :title => 'B001BR6ATG title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)

@po = @vendor.purchaseorders.create!(
    :code => 'L3064600',
    :condition=>'incomplete',
    :delivery_date=>Time.now,
    :marketplace=>'US',
    :status=>'pending_vendor_input'
)

@po.asins.create!(
    :sku => 'B001BR6ATG',
    :title => 'B001BR6ATG title',
    :srq_impact_source => 'default',
    :status=>'pending_vendor_input'
)
