# ============================================================================================
# = A very complicated controller.  This can be nested under User or Persona, or standalone. =
# ============================================================================================

class RantsController < ApplicationController
  before_filter :logged_in?
  # GET /rants
  # GET /rants.xml
  def index   
    @rants = Rant.order(:created_at.desc).includes(:user, :persona)

    # if nested under user
    if params[:user_id]
      @user = User.find params[:user_id]
      @rants = @rants.where(:user_id >> params[:user_id])
    end
  end

  # GET /rants/1
  # GET /rants/1.xml
  def show
    @rant = Rant.find(params[:id])
    
    if params[:user_id]
      @user = params[:user_id]
    end
  end

  # GET /rants/new
  # GET /rants/new.xml
  def new
    @rant = Rant.new
    
    if !params[:user_id]
      @rant.user_id = current_user.id
    else # nested under user
      @user = User.find params[:user_id]
      @rant.user_id = current_user.id
    end
    
    @rant.ip = request.remote_ip

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rant }
    end
  end

  # GET /rants/1/edit
  def edit
    @rant = Rant.find(params[:id])
  end

  # POST /rants
  # POST /rants.xml
  def create
    @rant = Rant.new(params[:rant])

    respond_to do |format|
      if @rant.save
        format.html { redirect_to(@rant, :notice => 'Rant was successfully created.') }
        format.xml  { render :xml => @rant, :status => :created, :location => @rant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rants/1
  # PUT /rants/1.xml
  def update
    @rant = Rant.find(params[:id])

    respond_to do |format|
      if @rant.update_attributes(params[:rant])
        format.html { redirect_to(@rant, :notice => 'Rant was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rants/1
  # DELETE /rants/1.xml
  def destroy
    @rant = Rant.find(params[:id])
    @rant.destroy

    respond_to do |format|
      format.html { redirect_to(rants_url) }
      format.xml  { head :ok }
    end
  end
end
