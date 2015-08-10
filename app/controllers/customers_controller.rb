class CustomersController < ApplicationController
	before_action :set_customer, :only=>[:show,:edit,:update,:destroy]

	def index
		@customers = Customer.includes(:phones,:addresses=>[:city])
	end

	def new
		@customer = Customer.new
		@customer.phones.new
		@customer.addresses.new
		@customer.faxes.new
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			flash[:notice] = "客戶#{@customer.name} 儲存成功"
			redirect_to customer_path(@customer)
		else

			render 'customers/new'
		end

	end

	def show
	end

	def edit

	end

	def update
		if @customer.update(customer_params)
			flash[:notice] = "客戶#{@customer.name} 修改成功"
			redirect_to customer_path(@customer)
		else

			render 'customers/edit'
		end

	end

private
	def set_customer
		@customer = Customer.find(params[:id])
	end

	def customer_params
		params.require(:customer).permit(:code, :name, :description, :status,
															:phones_attributes=>[:number],
															:faxes_attributes=>[:number],
															:addresses_attributes=>[:address,:city_id,:district_id] )

	end
end
