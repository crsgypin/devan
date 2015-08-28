class Admin::UserPermissionsController < ApplicationController
	def index 
		@users = User.all
	end

	def update
		
		user = User.find(params[:id])
		user.update!(:status=>params[:status])

		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

end
