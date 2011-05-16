class HomeController < ApplicationController
  def index
    if current_user
      @rants = Rant.order(:created_at.desc).limit(5)
      @persona = current_user.followed_personas.order("rand()").first || Persona.first
    end
  end
end
