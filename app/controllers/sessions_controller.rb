class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])  

    if user
      session[:user_id] = user.id                  
      if !cookies[:return_url].nil?
        return_url = cookies[:return_url]
        cookies[:return_url] = nil
        redirect_to return_url
      else
        redirect_to root_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    cookies[:return_url] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
