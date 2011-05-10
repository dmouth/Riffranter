module ApplicationHelper           
  # options include :hide_browser_title, :hide_page_title
  def page_title title, options = {}
    hide_browser_title = options.has_key?(:hide_browser_title) ? options[:hide_browser_title] : false
    hide_page_title = options.has_key?(:hide_page_title) ? options[:hide_hide_title] : false
    
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
  
  # Wrapper to hide things that only admins should see
  def admin_area &block
    capture(&block) if current_user && current_user.admin?
  end
end
