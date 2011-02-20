class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    @current_user = session[:user_id] ? User.find(session[:user_id]) : nil
    @current_user
  end
  
  def signed_in?
    !!current_user
  end
  
  helper_method :current_user, :signed_in? # This makes these methods available in views
end
