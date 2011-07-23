#!/usr/bin/ruby

require File.dirname(__FILE__) + "/../config/application"
Rails.application.require_environment!


def get_temperatures (sensors)
	sensors.each do |sensor|
		probe_temp = sensor.temperature
		puts "#{sensor.name}: #{ sensor.hardware_type } #{ probe_temp }"
                save_temp sensor.id, sensor.name, probe_temp unless probe_temp == ""
	end
end

def save_temp (id,name,value)
    temp = Temperatures.new( "probe_id" => id,
                            "probe_name" => name,
                            "value" => value )
    temp.save
end

def main
	
	sensors = []
	CONFIG["devices"].each do |id,opts|
		if opts["type"].include?("TempSensor") then
			 sensor = Device::TempSensor.new(id,opts["name"])
			 sensors << sensor
		end
	end
	while true
		get_temperatures sensors
		sleep 60
	end
end

main
