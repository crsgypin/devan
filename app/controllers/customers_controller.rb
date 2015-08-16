class CustomersController < ApplicationController
	before_action :set_customer, :only=>[:show,:edit,:update,:destroy]
	before_action :authenticate_user!, :except=>[:index,:show]

	def index
		update_session_search
		@customers = Customer.includes(:phones,:addresses=>[:city]).joins(:phones,:addresses=>[:city])
		@customers = @customers.where(@seach_sql)
		@customers = @customers.where("addresses.city_id = #{@customer_city}") if @customer_city >0
		@customers = @customers.where(:status=>"經營中")
		@customers = @customers.page(params[:page]).per(30)

	end

	def profiles
		update_session_search
		@customers = Customer.includes(:phones,:addresses=>[:city]).joins(:phones,:addresses=>[:city])
		@customers = @customers.where(@seach_sql)
		@customers = @customers.where("addresses.city_id = #{@customer_city}") if @customer_city >0
		@customers = @customers.page(params[:page]).per(30)
		# @customers = @customers.where(["customers.name like ? OR address like ? OR number LIKE ?","%#{@customer_search}%","%#{key_address}%", "%#{key_number}%"])
	end

	def update_status
		@customer = Customer.find(params[:id])
		@customer.update(:status=>params[:status])
		respond_to do |format|
			format.json {render :json=>{:result=>"success"}}
		end

	end



	def show
	end

	def edit

	end


end
