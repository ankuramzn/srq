class CreatePurchaseorders < ActiveRecord::Migration
  def self.up
    create_table :purchaseorders do |t|
      t.string :code
      t.integer :vendor_id
      t.string :condition
      t.date :delivery_date
      t.string :marketplace
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :purchaseorders
  end
end
