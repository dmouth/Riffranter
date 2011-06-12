class PersonasController < ApplicationController
  before_filter :logged_in?
  before_filter :is_admin?, :except => [:index, :show, :follow, :unfollow]

  # GET /personas
  # GET /personas.xml
  def index
    @personas = Persona.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personas }
    end
  end

  # GET /personas/1
  # GET /personas/1.xml
  def show
    @persona = Persona.find(params[:id])
    @rants = @persona.rants.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @persona }
    end
  end

  # GET /personas/new
  # GET /personas/new.xml
  def new
    @persona = Persona.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @persona }
    end
  end

  # GET /personas/1/edit
  def edit
    @persona = Persona.find(params[:id])
  end

  # POST /personas
  # POST /personas.xml
  def create
    @persona = Persona.new(params[:persona])

    respond_to do |format|
      if @persona.save
        format.html { redirect_to(@persona, :notice => 'Persona was successfully created.') }
        format.xml  { render :xml => @persona, :status => :created, :location => @persona }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /personas/1
  # PUT /personas/1.xml
  def update
    @persona = Persona.find(params[:id])

    respond_to do |format|
      if @persona.update_attributes(params[:persona])
        format.html { redirect_to(@persona, :notice => 'Persona was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.xml
  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy

    respond_to do |format|
      format.html { redirect_to(personas_url) }
      format.xml  { head :ok }
    end
  end
  
  def follow
    throw "Illegal attempt to follow user!" if params[:current_user_id].to_i != current_user.id

    @persona = Persona.find params[:id] 
    
    current_user.followed_personas << @persona
    current_user.followed_persona_ids.uniq!  
    current_user.save
  end
  
  def unfollow
    throw "Illegal attempt to unfollow persona" if current_user.id != params[:current_user_id].to_i

    @persona = Persona.find params[:id]
    
    current_user.followed_personas.delete @persona
    current_user.save
  end
end
