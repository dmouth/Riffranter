class HomeController < ApplicationController
  def index
    if current_user
      @rants = Rant.order(:created_at.desc).includes(:user, :persona, :votes).limit(5)
      @persona = current_user.followed_personas.order("rand()").first || Persona.first
      @subscribed_rants = current_user.followed_rants
    end
  end
end
