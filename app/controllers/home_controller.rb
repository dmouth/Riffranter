class HomeController < ApplicationController
  before_filter :logged_in?, :except => :index

  def index
    if current_user
      # Newest rants
      @rants = Rant.order(:created_at.desc).includes(:user, :persona, :votes).limit(25)

      # Collections for synced dropdowns in persona rant widget 
      @categories = Category.order(:name).joins(:personas).select("distinct categories.*").all
      @personas = Persona.order(:name)
      @persona = Persona.for_category(@categories.first).first
    end    
  end  
  
  def hot_rants
    # I'd definitely love to not do it this way, but my Arel chops aren't together enough to pull this one off.
    @rants = Rant.hot(25)
  end
  
  def latest_rants
    @rants = Rant.order(:created_at.desc).includes(:user, :persona, :votes).limit(25)
  end
  
  def subscriber_rants
    # All rants for personas and users that the current user is following
    @rants = current_user.followed_rants.limit(25)
  end
end
