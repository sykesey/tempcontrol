class Recipe < ActiveRecord::Base
  has_one :mash_profile
  has_many :yeasts
  has_many :grains
  has_many :hops
  has_many :generic_ingredients
end
