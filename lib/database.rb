require 'active_record'
require 'yaml'
 
dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig["production"])

class Database
end

class Database::Temperature < ActiveRecord::Base
end
