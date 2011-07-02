
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

def read_device(id,param)
  val = `#{CONFIG["ow"]["bin"]}/owread -s #{CONFIG["ow"]["server"]} /#{id}/#{param}`.gsub(/\s/,'')
  return -1 if val.nil?
  return val
end

class Device
  attr_accessor :name, :id
  
  def get_device_parameter (param)
    read_device @id, param
  end
  
  def initialize (id)
    @id = id
  end

end

class Device::TempSensor < Device
  
  def temperature
    read_device_temperature(@id)
  end
  
end

class Device::GPIO < Device
  attr_accessor :num_pins
end

class Device::ADC < Device
  attr_accessor :num_pins
end

