module DashboardHelper
  
  def format_temp (temp)
      return '<span class="temp_value">' + temp.to_s + ' &deg;C</span>'
  end
  
  def format_delta (delta)
    if (delta < 0)
      return '<span class="temp_delta up">&Delta;5 + ' + delta.abs.to_s + ' &deg;C</span>'
    elsif (delta == 0)
      return '<span class="temp_delta flat">&Delta;5' + delta.to_s + ' &deg;C</span>'
    else
      return '<span class="temp_delta down">&Delta;5 - ' + delta.abs.to_s + ' &deg;C</span>'
    end
  end
  
  
end
