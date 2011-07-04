class DashboardController < ApplicationController
  
  def index
    @zones = 
    @last_temperature = Temperatures.last_probe_temps
  end
  
end
