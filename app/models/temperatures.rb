class Temperatures < ActiveRecord::Base
  
  def self.last_probe_temps
    temps = Hash.new { |h, k| h[k] = Hash.new(0) }
    probes = Temperatures.find(:all, :select => "probe_id", :group => "probe_id")
    probes.each do |row|
      name = row.probe_id
      temps[name]["current"] = Temperatures.where(:probe_id => name).order("created_at DESC").first.value
      temps[name]["fivemin"] = Temperatures.where(:probe_id => name).order("created_at DESC").limit(1).offset(5).first.value
      temps[name]["deltafive"] = temps[name]["current"] - temps[name]["fivemin"]
    end
    return temps
  end
  
  
  
end
