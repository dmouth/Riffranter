module RantsHelper
  
  def linkify rantText
    
    regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
    rantText.gsub!( regex, '<a href="\1">\1</a>' ) 
  end
end
