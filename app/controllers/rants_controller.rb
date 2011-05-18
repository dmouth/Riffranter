class RantsController < ApplicationController
  before_filter :logged_in?
  # GET /rants
  # GET /rants.xml
  def index   
    @rants = Rant.order(:created_at.desc).includes(:user, :persona).limit(5).all
  end

  # GET /rants/1
  # GET /rants/1.xml
  def show
    @rant = Rant.includes(:user, :persona).find(params[:id])
  end

  # GET /rants/new
  # GET /rants/new.xml
  def new
    @rant = Rant.new
    @rant.user_id = current_user.id
    @rant.ip = request.remote_ip
  end

  # GET /rants/1/edit
  def edit  
    @rant = Rant.find(params[:id])
    get_clearance if !owner_or_admin?(@rant.user_id)
  end

  # POST /rants
  # POST /rants.xml
  def create
    @rant = Rant.new(params[:rant])
    respond_to do |format|      
      if @rant.save
        format.html { redirect_to(@rant, :notice => 'Rant was successfully created.') }
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
    get_clearance if !owner_or_admin?(@rant.user_id)
    
    
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
    get_clearance if !owner_or_admin?(@rant.user_id)
    @rant.destroy

    respond_to do |format|
      format.html { redirect_to(rants_url) }
      format.xml  { head :ok }
    end
  end
  
  def new_ajax
    throw "Illegal attempt to create rant!" if params[:id].to_i != current_user.id
    @persona = Persona.find params[:persona_id]
    @text = params[:text]
    @rant = Rant.create! do |r|
      r.persona = @persona
      r.user = current_user
      r.body = @text    
      r.ip = request.remote_ip
    end
    
    @latest_rants = Rant.order(:created_at.desc).includes(:user, :persona).limit(5).all
  end
end
