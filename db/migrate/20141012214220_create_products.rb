class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :titre
      t.text :description
      t.string :image_url
      t.string :price
      t.string :decimal, :precision => 8, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
