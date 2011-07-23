class Schedule < ActiveRecord::Base
  has_one :recipe
  has_one :equipment
end
