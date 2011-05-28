class UsersController < ApplicationController
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

    # make sure that we reset the collection.  HTML returns nothing if no check boxes are selected, making it impossible
    # for a user to clear all of the boxes
    @user.followed_persona_ids ||= []

    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => "Profile updated successfully."
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

  def follow
    throw "Illegal attempt to follow user!" if params[:id].to_i != current_user.id

    @followed_user = User.find params[:follow_id]

    current_user.followed_users << @followed_user
    current_user.followed_user_ids.uniq!
    current_user.save
  end

  def unfollow
    throw "Illegal attempt to unfollow user!" if params[:id].to_i != current_user.id

    @followed_user = User.find params[:follow_id]

    current_user.followed_users.delete @followed_user
    current_user.save
  end
end
