class UserMailer < ActionMailer::Base
  default from: "noreply@theworldcupbracket.com"

  def send_register_email(attempt)
    @email_attempt = attempt
    @url = '/register?email='+@email_attempt.email+'&passcode='+@email_attempt.passcode
    attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
    mail(to: @email_attempt.email, subject: 'Welcome to The World Cup Bracket')
  end

  def send_join_group_email(group, email, user)
  	@group = group
  	@user = user
  	attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
    mail(to: email, subject: 'The World Cup Bracket - Group Invitation')
  end

  def self.send_join_email(group, emails, user)
  	recipients = emails.split(',')
  	email_error = false
  	email_errors = []
  	recipients.each do |recipient|
  		if valid_email?(recipient)
			UserMailer.send_join_group_email(group, recipient, user).deliver
		else
			email_error = false
			email_errors.add(recipient)
		end
		if(email_error)
			flash[:error] = "There were some errors sending the invitation emails " + email_errors
		else
			flash[:notice] = "All emails were sent successfully."
		end		
	end
  end

   def valid_email?(email)
    !(email =~ /.+@.+\..+/i).nil?
  end



end
