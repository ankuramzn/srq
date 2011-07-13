class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.integer :compliance_id
      t.string :url
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
