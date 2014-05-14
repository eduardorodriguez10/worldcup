class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :results_visible?, :to_boolean, :is_admin?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def results_visible? 
    return (Time.now > cutover_time)
  end

  def cutover_time
    ActiveSupport::TimeZone["Brasilia"].parse("2014-06-12 4pm")
  end

  def require_user
  	if !logged_in?
  		flash[:error] = "Must be logged in to do that."
  		redirect_to root_path
  	end
  end

  def require_same_user(user_id)
    if (!logged_in? || current_user.id != user_id)
      flash[:error] = "Access denied."
      redirect_to root_path
    end
  end

  def require_admin
    if (!logged_in? || !current_user.admin)
      flash[:error] = "Access denied."
      redirect_to root_path
    end
  end

  def is_admin? 
     current_user.admin
  end 

  def items_per_page
    15
  end

  def to_boolean(str)
    str == 'true'
  end

  def valid_email?(email)
    !(email =~ /.+@.+\..+/i).nil?
  end
  
  def user_email_exists?(email)
    !User.find_by(email: email).nil?
  end

  def user_attempt_exists?(email)
    !RegisterAttempt.find_by(email: email).nil?
  end

  def generate_registration_code
    (0...12).map { (65 + rand(26)).chr }.join
  end


end
