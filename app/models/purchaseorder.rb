class Purchaseorder < ActiveRecord::Base
  belongs_to :vendor
  has_many :asins
end
