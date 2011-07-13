class CreateAsins < ActiveRecord::Migration
  def self.up
    create_table :asins do |t|
      t.string :sku
      t.integer :purchaseorder_id
      t.integer :compliance_id
      t.datetime :association_at
      t.string :title
      t.string :srq_impact_source
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :asins
  end
end
