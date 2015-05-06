# File: rating.rb
# Purpose of class: Defines the relationship between users, medics and ratings
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
require "user"
require "medic"

class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :medic
end
