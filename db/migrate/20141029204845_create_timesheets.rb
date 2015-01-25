class CreateTimesheets < ActiveRecord::Migration
  def self.up
    create_table :timesheets do |t|
      t.integer :user_id
      t.integer :delivery_id
      t.string :periode
      t.timestamps
    end
  end
  def self.down
    drop_table :timesheets
  end
end
