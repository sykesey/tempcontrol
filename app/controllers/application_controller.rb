class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #include the "other" stuff?
  require "lib/bootstrap.rb"
end
