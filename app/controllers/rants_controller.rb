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
    # if nested under persona
    elsif params[:persona_id]
      @persona = Persona.find params[:persona_id]
      @rants = @rants.where(:persona_id >> params[:persona_id])
    end
  end

  # GET /rants/1
  # GET /rants/1.xml
  def show
    @rant = Rant.includes(:user, :persona).find(params[:id])
    
    if params[:user_id]
      @user = @rant.user
    elsif params[:persona_id]
      @persona = @rant.persona
    end
  end

  # GET /rants/new
  # GET /rants/new.xml
  def new
    @rant = Rant.new
    
    if params[:user_id]
      @user = User.find params[:user_id]
      @rant.user_id = current_user.id   
    elsif params[:persona_id]
      @persona = Persona.find params[:persona_id]
      @rant.persona_id = @persona.id
      @user = current_user
    else 
      @rant.user_id = current_user.id
    end
    
    @form_url = form_url
    
    @rant.ip = request.remote_ip

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rant }
    end
  end

  # GET /rants/1/edit
  def edit
    @rant = Rant.find(params[:id])
    @form_url = form_url
  end

  # POST /rants
  # POST /rants.xml
  def create
    @rant = Rant.new(params[:rant])
    @form_url = form_url
    
    respond_to do |format|      
      if @rant.save
        format.html { redirect_to(@form_url, :notice => 'Rant was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rant.errors, :status => :unprocessable_entity }  
        format.js
      end
    end
  end

  # PUT /rants/1
  # PUT /rants/1.xml
  def update
    @rant = Rant.find(params[:id]) 
    @form_url = form_url 
    
    respond_to do |format|
      if @rant.update_attributes(params[:rant])
        format.html { redirect_to(@form_url, :notice => 'Rant was successfully updated.') }
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
    return_url = form_url

    respond_to do |format|
      format.html { redirect_to(return_url) }
      format.xml  { head :ok }
    end
  end
  
  def form_url       
    # adjust return url in case of nested resource
    if params[:user_id]  
      @user = User.find(params[:user_id])
      return_url = [@user, @rant] 
    elsif params[:persona_id]
      @persona = Persona.find(params[:persona_id])
      return_url = [@persona, @rant] 
    else
      return_url = @rant
    end
  end
end
