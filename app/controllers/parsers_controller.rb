################################################################################File: parsers_controller.rb
#Purpose: Populates the database with file named schedule.csv
#Notice: TEM-DF. Todos Direitos Reservados
###############################################################################

class ParsersController < ApplicationController

	# Reload the page index
	def index
		render "index"
	end

	# Upload schedule.csv file in the database
 	def upload
		document = params[:document]
		if document
			File.open(Rails.root.join('public', 'csv', 'schedules.csv'), 'wb') {     |file| file.write(document.read)
			}
			Parser.save_data('public/csv/schedules.csv')
			redirect_to root_path
		else
			redirect_to 'http://0.0.0.0:3000/parsers'
		end
	end
end
