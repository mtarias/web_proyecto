class UserMailer < ActionMailer::Base
  default :from => "eventmakerg1@gmail.com"
 
  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.email}"
    @url  = "http://localhost:3000/profile"
    mail(:to => user.email, :subject => "Bienvnido a EventMaker", :template_path => 'layouts', :template_name => 'home') do |format|
      format.html { render :layout => 'home' }
      format.text
    end
  end
end
