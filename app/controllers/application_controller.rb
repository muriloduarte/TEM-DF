# File: application_controller.rb 
# Purpose of class: This class is a controller and contains action methods for 
# general application view.
# This software follows GPL license.
# TEM-DF Group
# FGA-UnB Faculdade de Engenharias do Gama - Universidade de Brasília
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :list_speciality, :list_work_unit_name, :work_unit_link

	# Verify if some user is logged on TEM-DF
	def current_user

		# Verify the current user logged, if nil, then storages the user by his 
		# session id
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def index	
	end

  private

  # List all medics specialities and call get_by_speciality_or_work_unit 
  # method. 
	def list_speciality
		@medic  = Medic.all
		get_by_speciality_or_work_unit(@medic)
	end

	# List all work units name specialities and call
	# get_by_speciality_or_work_unit method.
	def list_work_unit_name
		@work_unit = WorkUnit.all
		get_by_speciality_or_work_unit(@work_unit)
	end

	# REVIEW: the argument object1 and "it" must be renamed! 
	# Gets the doctor wich is passed in argument through of his speciality or    # work unit.
	def get_by_speciality_or_work_unit(object_to_determine_type)
		@speciality = []
		@work_unit_name = []

		#variable bool which storage if the argument type is medic object
		medic = true 

		object_to_determine_type.each do |object|

			# Verify the object type.
			# If medic object, include speciality on spaciality array unless is
			# included.
			# Else not be medic object, then will be a work unit and it name will be
			# included on work_unit_name unless be not is included this.
			if object.kind_of?(Medic)
				unless @speciality.include?(object.speciality)
					@speciality.push(object.speciality)
				end
			else
				unless @work_unit_name.include?(object.name)
					@work_unit_name.push(object.name)
				end
				medic = false
			end
		end

		# If medic is true, then return speciality array, else, return work unit
		# name array.
		if medic
			@speciality
		else
			@work_unit_name
		end
	end
end
