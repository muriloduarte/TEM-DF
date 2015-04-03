################################################################################File: work_unit.rb
#Purpose: Relationship between work units and medical
#Notice: TEM-DF. Todos Direitos Reservados
###############################################################################

class WorkUnit < ActiveRecord::Base

	has_many :medics
end
