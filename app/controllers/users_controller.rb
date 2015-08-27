class UsersController < ApplicationController
	before_action :authenticate_user!

	def show_profile
		@user = current_user
	end

	def edit_profile
		@user = current_user
	end

	def update_profile
		@user = current_user
		@user.update!(user_params)
		render 'users/edit_profile'
	end

private
	def user_params
		params.require(:user).permit(:name,:username,:email)
	end


end
