require 'rb-pid-controller'


def read_device_temperature(id)
  read_device id, "temperature"
end

def read_device_temphigh(id)
  read_device id, "temp_high"
end

def read_device_templow(id)
  read_device id, "temp_low"
end

def read_device_type(id)
  read_device id, "type"
end

#only useful if we have a powered 1-wire bus, which we don't??
def send_simultaneous_temperature
   `#{CONFIG["ow"]["bin"]}/owwrite -s #{CONFIG["ow"]["server"]} /simultaneous/temperature 1 2>/dev/null`
end

def read_device(id,param)
  val = `#{CONFIG["ow"]["bin"]}/owread -s #{CONFIG["ow"]["server"]} /#{id}/#{param} 2>/dev/null`.gsub(/\s/,'')
  return -1 if val.nil?
  puts "#{id}/#{param}: #{val}"  if CONFIG["debug"]
  return val
end

def write_device(id,param,value)
  `#{CONFIG["ow"]["bin"]}/owwrite -s #{CONFIG["ow"]["server"]} /#{id}/#{param} #{value} 2>/dev/null`
end

def get_alarms
  `#{CONFIG["ow"]["bin"]}/owdir -s #{CONFIG["ow"]["server"]} /alarms 2>/dev/null`.split(/\n/)
end

class Device
  attr_accessor :name, :id
  
  def get_device_parameter (param)
    read_device @id, param
  end
  
  def initialize (id,name)
    @id = id
    @name = name
  end
  
  def hardware_type
    read_device_type @id
  end

  def write_device_parameter (param,value)
    write_device(id,param,value)
  end

end

class Device::TempSensor < Device
  
  def temperature
    @temperature = read_device_temperature(@id)
    #warn "No temperature returned - is owserver running?" if @temperature == ""
    return @temperature
  end
  
  def set_temphigh(value)
    write_device(@id,"temphigh",value)
  end
  
  def set_templow(value)
    write_device(@id,"templow",value)
  end
  
end

class Device::Switch < Device
  attr_accessor :channels
  
  def initialize(id,name,channels)
    @id = id
    @name = name
    @channels = channels
  end
end

class Device::Switch::Channel < Device
  attr_accessor :switch, :pidcontroller
  
  def initialize(id,name,switch)
    @id = id
    @name = name
    @switch = switch
  end
  
  def on
   write_device(@id,@name,1)
  end

  def off
   write_device(@id,@name,0)
  end

  def is_on?
    return ( read_device(@id,@name).to_i == 1 ? true : false)
  end

  def is_off?
   return ( read_device(@id,@name).to_i == 0 ? true : false)
  end
  
end

class Device::ADC < Device
  attr_accessor :num_pins, :input_voltage_range
end

