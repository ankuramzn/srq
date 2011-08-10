class DropFaultyTables < ActiveRecord::Migration
  def self.up
    drop_table :packaging_data
    drop_table :weee_product_data
  end

  def self.down
  end
end
