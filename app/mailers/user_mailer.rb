class UserMailer < ActionMailer::Base
  default :from => "noreply@riffranter.com"

  def follower_update(rant)
    @rant = rant
    users = rant.persona.following_users | rant.user.following_users
    for @user in users
      mail(:to => "#{@user.full_name} <#{@user.email}>", :subject => "#{rant.persona.name} says...").deliver
    end
  end
end
