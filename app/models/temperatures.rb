class Temperatures < ActiveRecord::Base
  
  def self.last_probe_temps
    temps = Hash.new { |h, k| h[k] = Hash.new(0) }
    probes = Temperatures.find(:all, :select => "probe_name", :group => "probe_name")
    probes.each do |row|
      name = row.probe_name
      temps[name]["current"] = Temperatures.where(:probe_name => name).order("created_at DESC").first.value
      temps[name]["fivemin"] = Temperatures.where(:probe_name => name).order("created_at DESC").limit(1).offset(5).first.value
      temps[name]["deltafive"] = temps[name]["current"] - temps[name]["fivemin"]
    end
    return temps
  end
  
  
  
end
