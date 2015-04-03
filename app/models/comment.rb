# File: comment.rb
# Purpose: Responsible for processing, validating, associate, and other tasks 					 in the treatment of comment's data.
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília

class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :medic
	has_many :relevance

	validates :content, presence: true, length: { maximum: 300 }
end
