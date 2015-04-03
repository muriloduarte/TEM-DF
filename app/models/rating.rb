################################################################################File: rating.rb
#Purpose: Defines the relationship between users, medics and ratings
#Notice: TEM-DF. Todos Direitos Reservados
###############################################################################

require "user"
require "medic"

class Rating < ActiveRecord::Base

	belongs_to :user
	belongs_to :medic
end
