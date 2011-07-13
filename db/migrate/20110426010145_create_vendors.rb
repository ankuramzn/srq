class CreateVendors < ActiveRecord::Migration
  def self.up
    create_table :vendors do |t|
      t.string :code
      t.string :name
      t.string :contact
      t.boolean :is_import
      t.boolean :is_private_label

      t.timestamps
    end
  end

  def self.down
    drop_table :vendors
  end
end
