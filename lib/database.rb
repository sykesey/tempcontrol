require 'active_record'
require 'yaml'
 
dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)

class Temperature < ActiveRecord::Base
end
