# Sets the relevance of a comment
class Relevance < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :comment
end
