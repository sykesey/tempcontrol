class DashboardController < ApplicationController
  
  def index
    @zones = CONFIG["zones"]
    @last_temperature = Temperatures.last_probe_temps
  end
  
end
