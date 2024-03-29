class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :current_user?
  helper_method :owner_or_admin?
  
  def is_admin?          
    if !current_user || (current_user && !current_user.admin?)
      get_clearance
    end
  end

  def logged_in?
    if !current_user 
      get_clearance
    end
  end                
  
  # grabs requested URL and prompts for better (or any) login
  # works with sessions controller to do nice redirects
  def get_clearance 
    flash[:alert] = "You must be logged or have administrator clearance to go there."
    cookies[:return_url] = request.fullpath
    redirect_to(log_in_url)
  end
  
  def owner_or_admin? user
    if user.is_a? User
      current_user.admin? || user == current_user
    else # assuming an id
      current_user.admin? || user == current_user.id
    end
  end
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end                         
  
  def current_user?
    !current_user.nil?
  end 
end
