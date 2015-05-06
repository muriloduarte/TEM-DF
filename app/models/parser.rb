require "csv"
require "medic"
require "date"
require "schedule"
require "work_unit"

# REVIEW: Maybe would be better if the method save_data stay on medic.rb.
# File: parser.rb
# Purpose of class: This class is a model and contains attributes,            # associations and business methods for Medic entity.
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class Parser < ActiveRecord::Base
	# Method to fill database
	# file = '/public/csv/schedules.csv'
	# columns from csv file:
	# 0 - Nome da Unidade
	# 1 - Descrição da Lotação
	# 2 - Matrícula Funcional
	# 3 - Nome do Servidor
	# 4 - Cargo do Servidor
	# 5 - Data de início
	# 6 - Data de fim
	# 7 - Horário de entrada
	# 8 - Horário de saída
	
	def self.save_data(file)
		CSV.foreach(file, :col_sep => ";", :headers => true ) do |row|
			start_date = DateTime.parse(row[5] + " " + row[7])
			formatted_start_date = start_date.strftime("%a %b %d %H:%M")
			end_date = DateTime.parse(row[6] + " " + row[8])
			formatted_end_date = end_date.strftime("%a %b %d %H:%M")          	
	    work_unit_record = WorkUnit.find_or_create_by(:name => row[0])
	    params_medic_record = { :name => row[3], 
	    												:average => 0,
	    												:registry => row[2],
	      											:speciality => row[4],
	      											:department => row[1] 
	    											}
	    medic_record = work_unit_record.medics.find_or_create_by(params_medic_record
	    	)
	    medic_record.schedules.create(:in => formatted_start_date, 
	    															:out => formatted_end_date
	    														 )
		end
	end
end
