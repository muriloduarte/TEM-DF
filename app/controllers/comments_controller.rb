class CommentsController < ApplicationController
	# Method to report a comment
	def reports
		@user = User.find_by_id(session[:remember_token])
    if @user && @user.username == "admin"
			@reported_comments = Comment.all.where(report: true)
		else
			redirect_to root_path
		end
	end

	# Method to deactivate a comment
	def deactivate
		@comment = Comment.find_by_id(params[:comment_id])
		if @comment
			@comment.update_attribute(:comment_status, false)
		else
			# Nothing to do
		end
		redirect_to reported_comments_path
	end

	# Method to reactivate a comment
	def reactivate
		@comment = Comment.find_by_id(params[:comment_id])
		if @comment
			@comment.update_attribute(:comment_status, true)
		else
			# Nothing to do
		end
		redirect_to reported_comments_path
	end

	# Method to remove the report in a comment
	def disable_report
		@comment = Comment.find_by_id(params[:comment_id])
		if @comment
			@comment.update_attribute(:report, false)
		else
			# Nothing to do
		end
		redirect_to reported_comments_path
	end
end