class Admin::CustomersController < ApplicationController


	def deliveried_days

		# @customers = Customer.includes(:form_values=>:daily_form).joins(:form_values=>:daily_form)
		@customers = Customer.includes(:form_values=>:daily_form).joins(:form_values=>:daily_form)
		@customers = @customers.where('daily_forms.date > ?', Time.now-7.days)
		@customers = @customers.page(params[:page]).per(30)
	end

	def delivery_plan_days
		@customers = Customer.includes(:customer_delivery_day).joins(:customer_delivery_day)
		@customers = @customers.order("#{params[:sort]} desc") if params[:sort]
		@customers = @customers.page(params[:page]).per(30)
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
															:addresses_attributes=>[:address,:city_id,:district_id],
															:customer_delivery_day_attributes=>[:id, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :unstable_day] )
	end

	def update_session_search
		session[:customer_search] = params[:customer_search] if params[:customer_address]
		session[:customer_city] = params[:customer_city].to_i if params[:customer_city]
		list = %w(customer_code customer_name customer_address customer_phone)
		list.each do |item|
			if params[item]
				if params[item].to_i == 1
					session[item] = true
				else
					session[item] = false
				end
			else
				session[item]= true if session[item] ==nil
			end
		end

		@customer_search = session[:customer_search]
		@customer_code = session[:customer_code]
		@customer_phone = session[:customer_phone]
		@customer_name = session[:customer_name]
		@customer_address = session[:customer_address]
		@customer_city = session[:customer_city] ||=0

		states = []
		states<< "customers.code LIKE '%#{@customer_search}%'" if @customer_code
		states<< "customers.name LIKE '%#{@customer_search}%'" if @customer_name
		states<< "address LIKE '%#{@customer_search}%'" if @customer_address
		states<< "number LIKE '%#{@customer_search}%'" if @customer_phone
		@seach_sql = "#{states.join(" OR ")}"

	end
end