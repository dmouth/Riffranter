class HomeController < ApplicationController
  def index
    if current_user
      @rants = Rant.order(:created_at.desc).limit(5)
    end
  end
end
