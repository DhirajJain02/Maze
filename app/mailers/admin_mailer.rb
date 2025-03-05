class AdminMailer < ApplicationMailer
  default from: "akshat.jain@jarvis.consulting"
  layout "mailer"

  def notify(new_user)
    @new_user=new_user

    admin_emails = User.with_role(:admin).pluck(:email)
    mail(to: admin_emails, subject: "New User Created: #{@new_user.first_name} #{@new_user.last_name}")
  end
end
