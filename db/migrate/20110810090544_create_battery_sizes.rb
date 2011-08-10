class CreateBatterySizes < ActiveRecord::Migration
  def self.up
    create_table :battery_sizes do |t|
      t.string :size

      t.timestamps
    end
  end

  def self.down
    drop_table :battery_sizes
  end
end
