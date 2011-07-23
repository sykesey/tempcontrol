class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #include the "other" stuff?
  #require "lib/bootstrap.rb"
  if CONFIG.nil?
    open('../../config/config.json', 'r') { |f| CONFIG = JSON.load(f) }
  end
end
