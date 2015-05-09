# File: work_unit.rb
# Purpose of class: Relationship between work units and medical
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class WorkUnit < ActiveRecord::Base
	has_many :medics
end
