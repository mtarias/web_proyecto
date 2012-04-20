class EstaticoController < ApplicationController
  def index
  end

  def login
    if usuario = Usuario.login(params[:usuario][:nick], params[:usuario][:password])
      session[:usuario_id] = usuario.id
      redirect_to :root, :notice => "Bienvenido #{usuario.nombre}!"
    else
      redirect_to :root, :notice => "Nombre de usuario o password incorrecto!"
    end
  end
end
