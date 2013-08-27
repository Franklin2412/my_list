class SessionsController < ApplicationController
	
	before_action :signed_out_user, only: [:new, :create]
	
	def new
	end
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else
			flash.now[:error] = "Email Password Mismatch!."
			render 'new'
		end
	end
	def destroy
		sign_out
		redirect_to signin_path
	end
	private
		def signed_out_user
			redirect_to current_user if signed_in?
		end
end
