class UsersController < ApplicationController
  before_filter :is_admin?, :only => :index
  before_filter :logged_in?, :except => [:new, :create]

  def index
    @users = User.order(:last_name).order(:first_name)
  end
  
  def new
    @user = User.new
  end       
  
  def edit      
    @user = User.find params[:id]
    get_clearance if !owner_or_admin?(@user)
  end                      
  
  def show
    @user = User.find params[:id]    
  end     
  
  def update
    @user = User.find params[:id]
    get_clearance if !owner_or_admin?(@user)

    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save     
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
end