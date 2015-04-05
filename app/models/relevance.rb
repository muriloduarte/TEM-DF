# File: relevance.rb
# Purpose of class: Sets the relevance of a comment
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class Relevance < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :comment
end
