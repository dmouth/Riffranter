module StaticContentHelper
  def read_content(content_section)
    textilize(File.open("#{Rails.root}/public/#{content_section}.markdown").read).html_safe
  end
end
