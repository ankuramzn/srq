class AddBatteryTypeToCompliances < ActiveRecord::Migration
  def self.up
    add_column :compliances, :battery_type, :string
  end

  def self.down
    remove_column :compliances, :battery_type
  end
end
