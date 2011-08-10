class CreateProductDetails < ActiveRecord::Migration
  def self.up
    create_table :product_details do |t|
      t.integer :compliance_id
      t.string :weee_category
      t.float :net_product_wt

      t.timestamps
    end
  end

  def self.down
    drop_table :product_details
  end
end
