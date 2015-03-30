# Relationship between schedules and medic
class Schedule < ActiveRecord::Base

	belongs_to :medic
end
