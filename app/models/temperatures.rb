class Temperatures < ActiveRecord::Base
  
  #class method?
  def self.last_probe_temps
    temps = {}
    temps["probe_1"] = Temperatures.where(:probe_name => "Probe 1").last
    temps["probe_2"] = Temperatures.where(:probe_name => "Probe 2").last
    temps["probe_3"] = Temperatures.where(:probe_name => "Probe 3").last
    return temps
  end
  
end
