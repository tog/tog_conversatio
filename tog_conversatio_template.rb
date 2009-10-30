#plugin 'thinking-sphinx', :git => "git://github.com/freelancing-god/thinking-sphinx.git"
gem "RedCloth", :lib => "redcloth", :source => "http://code.whytheluckystiff.net"

puts "\n"
if yes?("Install required gems as root? (y/n). Please, answer 'n' if you are in windows")
  rake "gems:install", :sudo => true
else
  rake "gems:install", :sudo => false
end

plugin 'tog_conversatio', :git => "git://github.com/tog/tog_conversatio.git"

route "map.routes_from_plugin 'tog_conversatio'"

generate "update_tog_migration"

#if yes?("Generate sphinx index? (only for MySQL and PostgreSQL) (y/n)")
#  rake "thinking_sphinx:index"
#end
rake "db:migrate"

