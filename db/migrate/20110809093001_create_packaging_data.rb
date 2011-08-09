class CreatePackagingData < ActiveRecord::Migration
  def self.up
    create_table :packaging_data do |t|
      t.integer :compliance_id
      t.integer :paper_cardboard_wt
      t.integer :plastic_wt
      t.integer :other_wt

      t.timestamps
    end
  end

  def self.down
    drop_table :packaging_data
  end
end
