class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_browser
  helper_method :current_user, :logged_in?, :results_visible?, :to_boolean, :is_admin?, :admin_view?, :positions_defined, :cutover_time, :valid_email?, :positions_defined_teams, :get_browser

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def results_visible? 
    return (Time.now > cutover_time)
  end

  def set_browser(browser)
    @browser = browser
  end

  def get_browser
    return @browser
  end

  def cutover_time
    ActiveSupport::TimeZone["Brasilia"].parse("2014-06-12 3:45pm")
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

  def admin_view?
    current_user.admin_view
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

  def generate_random_code
    (0...12).map { (65 + rand(26)).chr }.join
  end

  def positions_defined_teams
    count = 0
    Team.all.each do |t|
      if (t.r16_defined && t.r16_madeit)
        count +=1
      end
      if (t.quaterfinals_defined && t.quaterfinals_madeit)
        count +=1
      end
      if (t.semifinals_defined && t.semifinals_defined)
        count +=1
      end
      if (t.final_defined && t.final_defined)
        count +=1 
      end
      if (t.third_match_defined && t.third_match_madeit)
        count +=1
      end
      if (t.third_place_defined && t.third_place_madeit)
        count +=1
      end
      if (t.champion_defined && t.champion_madeit)
        count +=1 
      end
    end
    return count
  end

  def positions_defined(bracket)
    count = 0
    for i in 97..104
          for x in 1..2
            if(bracket[i.chr+x.to_s+'s'] != -1)
              count += 1
            end
          end
    end
      for i in 49..56
         if(bracket['w'+i.to_s+'s'] != -1)
          count += 1
         end
      end
      for i in 57..60
          if(bracket['w'+i.to_s+'s'] != -1)
            count += 1
          end
      end
      for i in 61..62
          if(bracket['w'+i.to_s+'s'] != -1)
            count += 1
          end
      end
      for i in 61..62
          if(bracket['l'+i.to_s+'s'] != -1)
            count += 1
          end
      end
      if(bracket['thirds'] != -1)
        count += 1
      end
      if(bracket['champions'] != -1)
        count += 1
      end
      return count
  end

  private 
    Browser = Struct.new(:browser, :version)

    SupportedBrowsers = [
      Browser.new('Safari', '6.0.2'),
      Browser.new('Firefox', '19.0.2'),
      Browser.new('Chrome', '27.0.1364.160'),
    ]

    def check_browser
       user_agent = UserAgent.parse(request.user_agent)
      unless SupportedBrowsers.detect { |browser| user_agent >= browser }
        render 'welcome/unsupported_browser'
      else
        set_browser(user_agent.browser)
      end
    end
end
