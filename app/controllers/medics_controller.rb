class MedicsController < ApplicationController

	NOT_EXIST_RATING = 0
	NOT_EXIST_GRADE = "0"

	helper_method :array_speciality, :array_medics_quantity

	def results
		@medics = Medic.search(params[:list_specility], params[:list_work_unit_name																										 ])
		if @medics
  			@medics
  		else
  			flash.now.alert="Escolha um campo."
  			render "home/index"
  		end
	end

	def profile
		@medic = Medic.find_by_id(params[:id])
		@work_unit = WorkUnit.find_by_id(@medic.work_unit_id)
		@average = calculate_average(@medic)
		@ratings = Rating.all.where(medic_id: @medic.id).size
	end
	
	# REVIEW: Can be renamed.
	# Show the work units X  quantity medics by region.
	def workunits_graph
		@medics_size = []
		@unit_name = []
		@work_unit = WorkUnit.all
		@work_unit.each do |work_unit|
			quantity = Medic.all.where(work_unit_id: work_unit.id).size
			@medics_size.push(quantity)
			@unit_name.push(work_unit.name)
		end
	end

	def array_speciality (id_work_unit)
		@medic = Medic.all.where(work_unit_id: id_work_unit)
		@speciality = []
		@medic.each do |medic|
			unless @speciality.include?(medic.speciality)
				@speciality.push(medic.speciality)
			end
		end
		
		@speciality
	end

	def array_medics_quantity (id_work_unit, array_speciality)
		@medic = Medic.all.where(work_unit_id: id_work_unit)
		@medics_size_speciality = []
		array_speciality.each do |speciality|
			quantity = Medic.all.where(speciality: speciality,
																 work_unit_id: id_work_unit
																)
																.size
			@medics_size_speciality.push(quantity)
		end
		@medics_size_speciality
	end
	
	def rating
		medic_id = params[:medic_id]
		@user = User.find_by_id(session[:remember_token])
		@medic = Medic.find_by_id(medic_id)
		if @user != nil
			rating_status = ""
			@rating = Rating.find_by_user_id_and_medic_id(@user.id, @medic.id)
			if @rating != nil
				update_rating(@rating , params[:grade])
				rating_status = 'Avaliação Alterada!'
			else
				create_rating(@user, @medic)
				rating_status = 'Avaliação Realizada com sucesso!'
			end
			redirect_to action:"profile",id: medic_id, notice: rating_status
		else
			redirect_to login_path, :alert => "O Usuário necessita estar logado"
		end
	end

	def create_comment
		@user = User.find_by_id(session[:remember_token])
		@medic = Medic.find_by_id(params[:medic_id])
		if @user
			@comment = Comment.new(content: params[:content], date: Time.current,
				medic: @medic, user: @user, comment_status: true, report: false)
			@comment.save
			redirect_to profile_path(@medic)
		else
			redirect_to login_path, :alert => "O Usuário necessita estar logado"
		end
	end

	def create_relevance		
		@user = User.find_by_id(session[:remember_token])
		@comment = Comment.find_by_id(params[:comment_id])
	if @user == nil
		redirect_to login_path, :alert => "O Usuário necessita estar logado"
	elsif @comment
			@relevance = Relevance.find_by_user_id_and_comment_id(@user.id, @comment.id)
			if @relevance
				@relevance.update_attribute(:value, params[:value])
			else
				@relevance = Relevance.create(value: params[:value], user: @user, comment: @comment)
			end
		redirect_to action:"profile",id: params[:medic_id]
		end
	end

	def to_report
		@comment = Comment.find_by_id(params[:comment_id])
		if @comment.report == false
			@comment.update_attribute(:report, true)
		end
		flash[:notice] = "Comentário reportado."
		redirect_to action:"profile",id: params[:medic_id]
	end

	def ranking
		@medics = Medic.order(average: :desc).limit(10)
	end

  private 
	def create_rating(user, medic)
		@rating = Rating.new(grade: params[:grade], user: user, medic: medic, date: Time.current)
		@rating.save
	end

	def update_rating(rating,grade)
		if grade != NOT_EXIST_GRADE
			rating.update_attribute(:grade , grade)
      rating.update_attribute(:date , Time.current)
    else
    	# Nothing to do  
    end
	end

	# REVIEW: What is sum / (1.0 * @ratings.size? Create a variable for this.   # Rename the variable r of each
	def calculate_average(medic)
		@ratings = Rating.all.where(medic_id: medic.id)
		if @ratings.size == NOT_EXIST_RATING
			NOT_EXIST_RATING
		else
  		sum = 0
			@ratings.each { |r| sum += r.grade}
			arithmetic_mean_averange = sum / (1.0 * @ratings.size)
			medic.update_attributes(:average => arithmetic_mean_averang)
			arithmetic_mean_averange
		end
	end
end
