class AdminMailer < ApplicationMailer
  default from: "dhiraj.lodha@jarvis.consulting"
  layout "mailer"

  def notify(admin, new_user)
    @admin=admin
    @new_user=new_user
    mail(to: @admin.email, subject: "New User Created: #{@new_user.first_name} #{@new_user.last_name}")

    # admin_emails = User.with_role(:admin).pluck(:email)
    # mail(to: admin_emails, subject: "New User Created: #{@new_user.first_name} #{@new_user.last_name}")
  end
end
