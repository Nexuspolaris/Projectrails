class AddOmniautToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :email2, :string
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :name, :string
  end
  def self.down
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :email2, :string
    remove_column :users, :fname, :string
    remove_column :users, :lname, :string
    remove_column :users, :name, :string
  end
end
