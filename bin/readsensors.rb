#!/usr/bin/ruby

require '../lib/bootstrap.rb'


def get_temperatures
	CONFIG["devices"].each do |id,opts|
          if opts["type"].include?("TempSensor") then
		  sensor = Device::TempSensor.new(id)
		  probe_temp = sensor.temperature
                  warn "No probe temp returned - is owserver running?" if probe_temp == ""
		  puts "#{opts["name"]}: #{ read_device_type id } #{ probe_temp }"
                  save_temp id, opts["name"], probe_temp unless probe_temp == ""
          end
	end
end

def save_temp (id,name,value)
    temp = Database::Temperature.new( "probe_id" => id,
                            "probe_name" => name,
                            "value" => value )
    temp.save
end

def main
  while true
   get_temperatures
   sleep 60
  end
end

main
