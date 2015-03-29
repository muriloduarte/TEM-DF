class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :list_speciality, :list_work_unit_name, :work_unit_link

	# Verify if some user is logged on TEM-DF
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def index	
	end

  private
	def list_speciality
		@medic= Medic.all
		get_by_speciality_or_work_unit(@medic)
	end

	# List all the work unit names
	def list_work_unit_name
		@work_unit = WorkUnit.all
		get_by_speciality_or_work_unit(@work_unit)
	end

	# REVIEW: the argument object1 and "it" must be renamed! 
	# Gets the doctor wich is passed in argument through of his speciality or    # work unit.
	def get_by_speciality_or_work_unit(object1)
		@speciality = []
		@work_unit_name = []
		medic = true
		object1.each do |it|
			if it.kind_of?(Medic)
				unless @speciality.include?(it.speciality)
					@speciality.push(it.speciality)
				end
			else
				unless @work_unit_name.include?(it.name)
					@work_unit_name.push(it.name)
				end
				medic = false
			end
		end
		if medic
			@speciality
		else
			@work_unit_name
		end
	end
end
