class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.string :libelle
      t.integer :convention_id
      t.timestamps
    end
  end
  def self.down
    drop_table :deliveries
  end
end
