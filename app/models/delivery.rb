class Delivery < ActiveRecord::Base
  belongs_to :convention
  before_destroy :ensure_not_referenced_by_any_convention
  validates :libelle,:convention_id, :presence => true
  # s'asurer qu'il n'y a pas de convention ayant ce delivery
	def ensure_not_referenced_by_any_convention
    if conventions.count.zero?
			return true
		else
      errors.add(:base, 'présent pour une convention')
			return false
		end
	end

end
