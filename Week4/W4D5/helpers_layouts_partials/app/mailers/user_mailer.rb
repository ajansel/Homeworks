class UserMailer < ApplicationMailer
  default from: 'everybody@appacademy.io'

  def welcome_email(user)
    @user = user
    mail(to: user.username, subject: 'Welcome, to App Academy, we are excited to have you!')
  end
end
