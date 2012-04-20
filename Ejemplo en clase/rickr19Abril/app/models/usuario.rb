class Usuario < ActiveRecord::Base
  has_many :fotos, :dependent => :destroy 
  has_many :albums, :dependent => :destroy
  
  validates_presence_of :nombre, :apellido, :usuario, :password
  validates_confirmation_of :password
  
  def self.login(nombreUsuario, password)
    usuario = self.find_by_usuario(nombreUsuario)
    if usuario && password == usuario.password
      usuario
    else
      false
    end
  end
  
end
