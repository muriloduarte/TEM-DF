# Relationship between work units and medical
class WorkUnit < ActiveRecord::Base

	has_many :medics
end
