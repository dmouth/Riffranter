class HomeController < ApplicationController
  before_filter :logged_in?, :except => :index

  def index
    if current_user
      # Newest rants
      @rants = Rant.order(:created_at.desc).includes(:user, :persona, :votes).limit(5)

      # Collections for synced dropdowns in persona rant widget 
      @categories = Category.order(:name).all
      @personas = Persona.order(:name)
      @persona = Persona.for_category(@categories.first).first
    end    
  end  
  
  def hot_rants
    # I'd definitely love to not do it this way, but my Arel chops aren't together enough to pull this one off.
    @rants = Rant.find_by_sql("SELECT rants.id, rants.user_id, rants.persona_id, rants.body, rants.ip, rants.created_at, rants.updated_at, avg(votes.stars) as rating FROM rants INNER JOIN votes ON votes.rant_id = rants.id group by rants.id, rants.user_id, rants.persona_id, rants.body, rants.ip, rants.created_at, rants.updated_at order by rating desc limit 25")
  end
  
  def latest_rants
    @rants = Rant.order(:created_at.desc).includes(:user, :persona, :votes).limit(5)
  end
  
  def subscriber_rants
    # All rants for personas and users that the current user is following
    @rants = current_user.followed_rants
  end
end
