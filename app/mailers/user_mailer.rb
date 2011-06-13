class UserMailer < ActionMailer::Base
  default :from => "noreply@riffranter.com"

  def follower_update(rant)
    @rant = rant
    users = (rant.persona.following_users_for_mail | rant.user.following_users_for_mail).uniq
    for @user in users
      mail(:to => "#{@user.full_name} <#{@user.email}>", :subject => "#{rant.persona.name} says...").deliver
    end
  end  
end
