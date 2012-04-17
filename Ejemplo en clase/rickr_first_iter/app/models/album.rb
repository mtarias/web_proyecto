class Album < ActiveRecord::Base
  belongs_to :usuario
  has_many :albums_fotos
  has_many :fotos, :through => :albums_fotos
end
