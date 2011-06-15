class HomeController < ApplicationController
  def index
    if current_user
      # Newest rants
      @rants = Rant.order(:created_at.desc).includes(:user, :persona, :votes).limit(5)

      # Randomly select a persona for the rant widget  -- mysql local and postgre prod for now 
      @persona = current_user.followed_personas.order("rand()").first || Persona.first

      # All rants for personas and users that the current user is following
      @subscribed_rants = current_user.followed_rants

      # I'd definitely love to not do it this way, but my Arel chops aren't together enough to pull this one off.
      @hot_rants = Rant.find_by_sql("SELECT rants.id, rants.user_id, rants.persona_id, rants.body, rants.ip, rants.created_at, rants.updated_at, avg(votes.stars) as rating FROM rants INNER JOIN votes ON votes.rant_id = rants.id group by rants.id, rants.user_id, rants.persona_id, rants.body, rants.ip, rants.created_at, rants.updated_at order by rating desc limit 5")
    end
  end
end
