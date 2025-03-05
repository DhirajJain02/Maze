class AdminMailer < ApplicationMailer
  default from: "akshat.jain@jarvis.consulting"
  layout "mailer"

  def notify(user)
  end
end
