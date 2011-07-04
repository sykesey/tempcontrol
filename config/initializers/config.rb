CONFIG_file = File.open('config/config.json', 'r') { |f| f.read }
CONFIG = JSON.parse(CONFIG_file)
