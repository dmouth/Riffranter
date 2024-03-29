class PersonaRantWidgetController < ApplicationController
  before_filter :logged_in?
  
  def update_widget
    @persona = Persona.find params[:id]
  end
  
  def persona_changed
    @persona = Persona.find params[:id]
  end
  
  def category_changed
    @category = Category.find params[:id]
    @personas = Persona.for_category(@category).order(:name).all
    @persona = @personas.first
  end
  
  def new_persona_rant
    create_rant
  end

  def new_rant
    create_rant
    @latest_rants = @persona.rants.order(:created_at.desc).includes(:user, :persona).all
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
    UserMailer.delay.follower_update(@rant)
  end
end
