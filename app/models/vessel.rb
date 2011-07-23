class Vessel < ActiveRecord::Base
  has_many :valves
  has_many :temp_sensors
  
  
end
