class Product < ActiveRecord::Base
	tailleMinTitre = 4
	default_scope { order("titre") }
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	# s'asurer qu'il n'y a pas de line_item referant à ce product
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors.add(:base, 'présent dans des paniers')
			return false
		end
	end
	validates :titre, :description, :image_url, :presence => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	validates :titre, :uniqueness => true
	validates :titre, :length => {
		minimum: tailleMinTitre,
		:message => "le titre doit contenir minimum #{tailleMinTitre} caractères" }
	validates :image_url, :format => {
		:with => %r{\A*.(gif|jpg|png)\z}i,
		:message => 'doit etre au format gif, jpg, ou png'
	}
end
