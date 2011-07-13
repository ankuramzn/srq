class CreateLabs < ActiveRecord::Migration
  def self.up
    create_table :labs do |t|
      t.integer :compliance_id
      t.text :info
      t.date :testing_date
      t.string :report_number
      t.text :standards

      t.timestamps
    end
  end

  def self.down
    drop_table :labs
  end
end
