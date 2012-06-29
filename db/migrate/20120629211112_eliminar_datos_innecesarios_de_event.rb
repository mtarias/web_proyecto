class EliminarDatosInnecesariosDeEvent < ActiveRecord::Migration
  def change
    remove_column :events, :latitude
    remove_column :events, :longitude
    remove_column :events, :gmaps
  end
end
