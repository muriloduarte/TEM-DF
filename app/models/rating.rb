# Existential condition
require "user"
require "medic"

# Defines the relationship between users, medics and ratings
class Rating < ActiveRecord::Base

	belongs_to :user
	belongs_to :medic
end
