class CreateWeeeProductData < ActiveRecord::Migration
  def self.up
    create_table :weee_product_data do |t|
      t.integer :compliance_id
      t.string :weee_category
      t.integer :net_product_wt

      t.timestamps
    end
  end

  def self.down
    drop_table :weee_product_data
  end
end
