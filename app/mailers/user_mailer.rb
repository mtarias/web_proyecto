class UserMailer < ActionMailer::Base
  default :from => "mtarias@uc.com"
 
  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.email}"
    @url  = "http://localhost:3000/profile"
    mail(:to => user.email) do |format|
      format.html { render :layout => 'home' }
      format.text
    end
  end
end
