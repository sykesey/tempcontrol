class Equipment < ActiveRecord::Base
  has_many :temp_sensors
  has_many :vessels
end
