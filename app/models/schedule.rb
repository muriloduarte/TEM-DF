################################################################################File: schedule.rb
#Purpose: Relationship between schedules and medic
#Notice: TEM-DF. Todos Direitos Reservados
###############################################################################

class Schedule < ActiveRecord::Base

	belongs_to :medic
end
