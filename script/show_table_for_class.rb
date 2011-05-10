ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'  
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")                                  

class_name = ARGV[0].classify
class_instance = ARGV[0].underscore

puts "# Index table----------------------------------------------------------------------------------------------------------------------------"
puts "<table cellpadding=\"5\" cellspacing=\"0\">"

puts "\t<tr>"
class_name.constantize.columns.each{|c| puts "\t\t<th valign=\"top\"><%= #{class_name}.human_attribute_name :#{c.name} %></th>"}
puts "<th></th>"
puts "\t</tr>"


puts "\t<% @#{class_instance.pluralize}.each do |#{class_instance}| %>"
puts "\t<tr>"
class_name.constantize.columns.each{|c| puts "\t\t<td valign=\"top\"><%= #{class_instance}.#{c.name} %></td>"}
puts "\t<td valign=\"top\">\n\t\t<%= link_to \"Show\", #{class_instance} %> |\n\t\t<%= link_to \"Edit\", edit_#{class_instance}_url(#{class_instance}) %> |\n\t\t<%= link_to \"Destroy\", #{class_instance}, :confirm => 'Are you sure?', :method => :delete %>
\t</td>"
puts "\t</tr>"
puts "\t<% end %>"

puts "</table>"                 
puts "# Index table----------------------------------------------------------------------------------------------------------------------------"


puts

puts "# Show table----------------------------------------------------------------------------------------------------------------------------"
puts '<table cellpadding="5" cellspacing="0">'
class_name.constantize.columns.each{|c| puts "\t<tr><th valign=\"top\"><%= #{class_name}.human_attribute_name :#{c.name} %></th><td valign=\"top\"><%= @#{class_instance}.#{c.name} %></td></tr>"}
puts "</table>"
puts "# Show table----------------------------------------------------------------------------------------------------------------------------"

puts

puts "# Formtastic fields----------------------------------------------------------------------------------------------------------------------"
puts "<%= semantic_form_for(@#{class_instance}) do |f| %>"
puts "\t<%= f.inputs do %>"
class_name.constantize.columns.each{|c| puts"\t\t<%= f.input :#{c.name} %>"}
puts "\t<% end %>"      
puts "\t<%= f.buttons%>"
puts "<% end %>"
puts "# Formtastic fields----------------------------------------------------------------------------------------------------------------------"

