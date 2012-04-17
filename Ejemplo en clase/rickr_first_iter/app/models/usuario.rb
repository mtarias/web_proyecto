class Usuario < ActiveRecord::Base
  has_many :fotos, :dependent => :destroy 
  has_many :albums, :dependent => :destroy
end
