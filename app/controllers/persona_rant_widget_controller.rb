class PersonaRantWidgetController < ApplicationController
  before_filter :logged_in?
  
  def update_widget
    @persona = Persona.find params[:id]
  end
  
  def new_persona_rant
    create_rant
    @latest_rants = Rant.order(:created_at.desc).includes(:user, :persona).limit(5).all
  end

  def new_rant
    create_rant
    @latest_rants = @persona.rants.order(:created_at.desc).includes(:user, :persona).limit(5).all
  end    
  
  private
  
  def create_rant
    throw "Illegal attempt to create rant!" if params[:id].to_i != current_user.id
    @persona = Persona.find params[:persona_id]
    @text = params[:text]
    @rant = Rant.create! do |r|
      r.persona = @persona
      r.user = current_user
      r.body = @text    
      r.ip = request.remote_ip
    end
  end
end
