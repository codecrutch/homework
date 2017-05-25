class UserMailer < ApplicationMailer
  default from: "ninelives@friskies.com"
  layout 'welcome_email'

  def welcome_email(user)
    @user = user
    @url = 'http://www.appacademy.io/happy_hour'
    mail(to: 'everybody@appacademy.io', subject: "W4D5 End-Of-Day")
  end
end
