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
		  temp = Temperature.new( "probe_id" => id, 
					  "probe_name" => opts["name"],
					  "value" => probe_temp )
                  temp.save
          end
	end
end

def main
  get_temperatures
end

main
