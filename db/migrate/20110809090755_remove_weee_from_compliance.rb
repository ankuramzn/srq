class RemoveWeeeFromCompliance < ActiveRecord::Migration
  def self.up
    remove_column :compliances, :paper_cardboard_wt
    remove_column :compliances, :plastic_wt
    remove_column :compliances, :metal_wt
    remove_column :compliances, :other_wt
    remove_column :compliances, :wee_category
    remove_column :compliances, :net_wt
    remove_column :compliances, :battery_description
    remove_column :compliances, :battery_brand
    remove_column :compliances, :battery_wt
  end

  def self.down
    add_column :compliances, :paper_cardboard_wt, :string
    add_column :compliances, :paper_cardboard_wt, :string
    add_column :compliances, :plastic_wt, :string
    add_column :compliances, :metal_wt, :string
    add_column :compliances, :other_wt, :string
    add_column :compliances, :wee_category, :string
    add_column :compliances, :net_wt, :string
    add_column :compliances, :battery_description, :string
    add_column :compliances, :battery_brand, :string
    add_column :compliances, :battery_wt, :string
  end
end

