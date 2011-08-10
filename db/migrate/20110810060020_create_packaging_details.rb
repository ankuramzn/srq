class CreatePackagingDetails < ActiveRecord::Migration
  def self.up
    create_table :packaging_details do |t|
      t.integer :compliance_id
      t.float :paper_cardboard_wt
      t.float :plastic_wt
      t.float :other_wt

      t.timestamps
    end
  end

  def self.down
    drop_table :packaging_details
  end
end
