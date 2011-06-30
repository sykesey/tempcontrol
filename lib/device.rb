
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
  `#{CONFIG["ow"]["bin"]}/owread -s #{CONFIG["ow"]["server"]} /#{id}/#{param}`.gsub(/\s/,'')
end
