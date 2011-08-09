class CreateBatteryDetails < ActiveRecord::Migration
  def self.up
    create_table :battery_details do |t|
      t.integer :compliance_id
      t.string :battery_type
      t.string :size
      t.integer :units
      t.string :packaging
      t.integer :battery_wt
      t.string :brand

      t.timestamps
    end
  end

  def self.down
    drop_table :battery_details
  end
end
