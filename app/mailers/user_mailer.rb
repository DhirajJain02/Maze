class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #
  default from: "dhiraj.lodha@jarvis.consulting"
  layout "mailer"

  def welcome_email(user)
    @user = user
    @login_url = new_user_session_url  # or your preferred URL
    mail(to: @user.email, subject: "Welcome to My Awesome App")
  end
  # def login_notification_email(user)
  #   @user = user
  #   mail(to: @user.email, subject: "You just logged in!")
  # end
end
