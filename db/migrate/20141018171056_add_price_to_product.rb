class AddPriceToProduct < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal
    LineItem.all.each do |line_item|
    	product = Product.find(line_item.product_id)
    	line_item.price = product.price
    	line_item.save
    end

  end
  def self.down
  	remove_column :line_items, :price
  end
end
