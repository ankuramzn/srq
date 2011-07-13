class CreateCompliances < ActiveRecord::Migration
  def self.up
    create_table :compliances do |t|
      t.string :sku
      t.string :vendor_product_number
      t.string :brand
      t.integer :vendor_id
      t.string :status
      t.integer :standard_id
      t.text :importer_of_record
      t.text :keeper_of_record
      t.date :manufacture_date
      t.string :manufacture_place
      t.string :esignature
      t.string :position
      t.text :comments_internal
      t.text :comments_external
      t.string :vendor_notes
      t.datetime :last_activity_at

      t.timestamps
    end
  end

  def self.down
    drop_table :compliances
  end
end
