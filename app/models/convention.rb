class Convention < ActiveRecord::Base
  has_many :delivery, :dependent => :destroy
  #scope :conventionuser , -> { order(:libelle) }
  default_scope  { order(:libelle) }
  accepts_nested_attributes_for :delivery, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  
end
