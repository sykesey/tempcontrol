#!/usr/bin/ruby

require File.dirname(__FILE__) + "/../config/application"
Rails.application.require_environment!


def run_loop (devices,zones)
	
	devices.each do |device|
		if device.is_a?(Device::TempSensor)
		  probe_temp = device.temperature
		  puts "#{device.name}: #{ device.hardware_type } #{ probe_temp }"
                  save_temp device.id, device.name, probe_temp unless probe_temp == ""
		elsif device.is_a?(Device::Switch)
		  #code logic here to flip the switch - for the moment let's just toggle the channels
		else
		  puts "No run_loop definition for #{device.class}"
		end
	end
	zones.each do |name,zone|
		if zone["manage"]
			#for the moment just do default_target_temp
			temp = Temperatures.find_last_by_probe_id(zone["sensor"]).value
			switch = get_device_by_id(devices,zone["heater"]["switch"])
			channel = get_channel_by_id_and_name(devices,zone["heater"]["switch"],zone["heater"]["channel"])
				
			if (temp <= zone["default_target_temp"])
				if channel.is_off?
				   puts "Switching heater on in #{name} as temp not hit yet (#{temp} < #{zone["default_target_temp"]})"
				   channel.on
				end
			else
				if channel.is_on?
					puts "Switching heater off in #{name} off as temp hit"
					channel.off
				end	
			end
			
			
		end
	end
end

#need zone code in here...

def save_temp (id,name,value)
    temp = Temperatures.new( "probe_id" => id,
                            "probe_name" => name,
                            "value" => value )
    temp.save
end

def get_device_by_id(devices,id)
	devices.each do |device|
		return device if device.id == id
	end
	return nil
end

def get_channel_by_id_and_name(devices,id,name)
	devices.each do |device|
		if (device.id == id ) # found switch
		    device.channels.each do |channel|
			return channel if channel.name == name
		    end
		end
	end
	return nil
end

def main
	
	devices = []
	CONFIG["devices"].each do |id,opts|
		if opts["type"].include?("TempSensor") then
			 sensor = Device::TempSensor.new(id,opts["name"])
			 devices << sensor
		end
		if opts["type"].include?("Switch") then
			channels = []
			opts["channels"].each do |chan|
				channels.push Device::Switch::Channel.new(id,chan,opts["name"])
			end
			switch = Device::Switch.new(id,opts["name"],channels)
			devices << switch
		end
	end
	
	while true
		run_loop devices, CONFIG["zones"]
		sleep 15
	end
end

main
