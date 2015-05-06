# File: schedule.rb
# Purpose of class: Relationship between schedules and medic
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class Schedule < ActiveRecord::Base
	belongs_to :medic
end
