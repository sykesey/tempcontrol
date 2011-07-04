class DashboardController < ApplicationController
  
  def index
    @last_temperature = Temperatures.last_probe_temps
  end
  
end
