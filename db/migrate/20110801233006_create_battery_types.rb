class CreateBatteryTypes < ActiveRecord::Migration
  def self.up
    create_table :battery_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :battery_types
  end
end
