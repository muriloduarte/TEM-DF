################################################################################File: relevance.rb
#Purpose: Sets the relevance of a comment
#Notice: TEM-DF. Todos Direitos Reservados
###############################################################################

class Relevance < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :comment
end
