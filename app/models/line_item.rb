class LineItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :cart
	def montant_ttc
		product.price.to_f * quantity
	end
end
