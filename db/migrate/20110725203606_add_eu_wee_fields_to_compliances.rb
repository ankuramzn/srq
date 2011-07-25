class AddEuWeeFieldsToCompliances < ActiveRecord::Migration
  def self.up
    add_column :compliances, :paper_cardboard_wt, :string
    add_column :compliances, :plastic_wt, :string
    add_column :compliances, :metal_wt, :string
    add_column :compliances, :other_wt, :string


    add_column :compliances, :wee_compliance, :boolean
    add_column :compliances, :wee_category, :string

    add_column :compliances, :net_wt, :string
    add_column :compliances, :contains_battery, :boolean
    add_column :compliances, :battery_description, :string
    add_column :compliances, :battery_brand, :string
    add_column :compliances, :battery_wt, :string
  end

  def self.down
    remove_column :compliances, :paper_cardboard_wt, :string
    remove_column :compliances, :plastic_wt, :string
    remove_column :compliances, :metal_wt, :string
    remove_column :compliances, :other_wt, :string


    remove_column :compliances, :wee_compliance, :boolean
    remove_column :compliances, :wee_category, :string

    remove_column :compliances, :net_wt, :string
    remove_column :compliances, :contains_battery, :boolean
    remove_column :compliances, :battery_description, :string
    remove_column :compliances, :battery_brand, :string
    remove_column :compliances, :battery_wt, :string
  end
end

