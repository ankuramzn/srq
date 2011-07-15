class AddPasswordInstrumentsToVendor < ActiveRecord::Migration
  def self.up
    add_column :vendors, :password_salt, :string
    add_column :vendors, :password_hash, :string
  end

  def self.down
    remove_column :vendors, :password_salt, :string
    remove_column :vendors, :password_hash, :string
  end
end
