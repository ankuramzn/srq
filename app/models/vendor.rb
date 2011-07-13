class Vendor < ActiveRecord::Base
  has_many :purchaseorders
  has_many :compliances
  has_many :asins, :through => :purchaseorders
end
