class Foto < ActiveRecord::Base
  belongs_to :usuario
  has_many :albums_fotos
  has_many :albums , :through => :albums_fotos
  accepts_nested_attributes_for :albums_fotos, :allow_destroy => true, :reject_if => :all_blank
end
