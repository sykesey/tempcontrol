#!/opt/local/bin/ruby

require 'rubygems'
require 'json'
require 'pp'

require 'lib/config.rb'
require 'lib/device.rb'
require 'lib/database.rb'


def get_temperatures
	CONFIG["devices"].each do |id,opts|
          if opts["type"] == "sensor" 
		  probe_temp = read_device_temperature id
		  puts "#{opts["name"]}: #{ read_device_type id } #{ probe_temp }"
                  save_temp id, opts["name"], probe_temp
          end
	end
end

def save_temp (id,name,value)
    temp = Temperature.new( "probe_id" => id,
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
