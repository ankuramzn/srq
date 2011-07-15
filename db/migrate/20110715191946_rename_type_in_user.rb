class RenameTypeInUser < ActiveRecord::Migration
  def self.up
    rename_column :users, :type, :user_type
  end

  def self.down
  end
end
