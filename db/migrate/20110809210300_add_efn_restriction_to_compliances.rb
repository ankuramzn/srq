class AddEfnRestrictionToCompliances < ActiveRecord::Migration
  def self.up
    add_column :compliances, :efn_availability, :string
    add_column :compliances, :efn_restrictions, :text
    add_column :compliances, :efn_restriction_reason, :text
  end

  def self.down
    remove_column :compliances, :efn_restriction_reason
    remove_column :compliances, :efn_restrictions
    remove_column :compliances, :efn_availability
  end
end
