# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
john = Usuario.create( :nombre => 'John', :apellido => 'Appleseed', :usuario => 'john', :password => '123456')
fotoPerfil = Foto.create(:nombre => 'Perfil', :descripcion => 'Foto de perfil', :archivo => 'john.jpg', :usuario => john )
primerAlbum = Album.create(:nombre => 'Primer Album', :descripcion => 'Mis primeras fotos', :usuario => john, :fotos => [ fotoPerfil ])
fotoSecundaria = Foto.create(:nombre => 'Secundaria', :descripcion => 'Foto sin importancia', :archivo => 'john.jpg', :usuario => john )
primerAlbum.albums_fotos.create(:foto => fotoSecundaria , :portada => true)