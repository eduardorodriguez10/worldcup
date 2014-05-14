class UserMailer < ActionMailer::Base
  default from: "noreply@theworldcupbracket.com"

  def send_register_email(attempt)
    @email_attempt = attempt
    @url = '/register?email='+@email_attempt.email+'&passcode='+@email_attempt.passcode
    mail(to: @email_attempt.email, subject: 'Welcome to The World Cup Bracket')
  end
end
