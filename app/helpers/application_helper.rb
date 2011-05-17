module ApplicationHelper           
  # =========================================================
  # = options include :hide_browser_title, :hide_page_title =
  # ========================================================= 
  def page_title title, options = {}
    hide_browser_title = options.has_key?(:hide_browser_title) ? options[:hide_browser_title] : false
    hide_page_title = options.has_key?(:hide_page_title) ? options[:hide_page_title] : false
    
    if !hide_browser_title
      content_for(:browser_title) do
        title
      end
    end

    if !hide_page_title
      content_for(:page_title) do
        title
      end
    end
  end  
  
  # ==========================================================
  # = Follow user and persona links, which can be kinda long =
  # ==========================================================
  
  def follow_user_link followed_user
    if current_user.followed_user_ids.include?(followed_user.id)
      internal_unfollow_user_link(followed_user)
    else
      internal_follow_user_link(followed_user)
    end
  end
  
  def internal_follow_user_link followed_user
    link_to "Follow User", follow_user_url(current_user), "data-current-user-id" => current_user.id, "data-follow-id" => followed_user.id, :class => "follow-user-link user-#{current_user.id}-followed-user-#{followed_user.id}"  
  end  

  def internal_unfollow_user_link followed_user
    link_to "Unfollow User", unfollow_user_url(current_user), "data-current-user-id" => current_user.id, "data-follow-id" => followed_user.id, :class => "unfollow-user-link user-#{current_user.id}-unfollowed-user-#{followed_user.id}"  
  end  
  
  # ======================================================
  # = Wrapper to hide things that only admins should see =
  # ======================================================
  def admin_area &block
    capture(&block) if current_user && current_user.admin?
  end     
  
  # ==========================
  # = Stuff to ease tab urls =
  # ==========================
  def tab_url_id text
    "tab-#{text.downcase.gsub(/\s/, "-")}"
  end
  
  def tab_url(text, url)
    local_options = {:id => tab_url_id(text)}                   
    link_to text, url, local_options
  end
end
