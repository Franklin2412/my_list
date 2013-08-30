class UsersController < ApplicationController

	before_action :signed_in_user , only: [:edit, :update, :show] 
	before_action :correct_user , only:[:edit, :update]
	before_action :show_to_correct_user, only: [:show]

	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to My List!..."
			redirect_to @user
		else
			render 'new'
		end
	end
	def show
		@user = User.find(params[:id])
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
    	@user = User.find(params[:id])
    	if @user.update_attributes(user_params)
      		flash[:success] = "Profile updated"
      		sign_in @user
      		redirect_to @user
    	else
    	  	render 'edit'
    	end
  	end
  	
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def signed_in_user
			redirect_to signin_url, notice: "Please Sign in to continue!" unless signed_in?
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to @user unless current_user?(@user)
		end
		def show_to_correct_user
			@user = User.find(params[:id])
			redirect_to current_user unless current_user?(@user)
		end
end
