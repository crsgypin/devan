class Admin::DeliveryPeopleController < ApplicationController
	before_action :set_delivery_person, :only=>[:show,:edit,:update,:destroy]
	before_action :authenticate_user!

	def index
		@active_delivery_people = DeliveryPerson.where(:status=>"在職")
		@inactive_delivery_people = DeliveryPerson.where(:status=>"離職")
		if params[:days]
			@limit_days = params[:days].to_i
		end
	end

	def form_values
		@delivery_person = DeliveryPerson.includes(:form_values=>:customer).find(params[:id])
		@form_values = @delivery_person.recent_form_values(params[:limitDays].to_i)

		respond_to do |format|
			format.json {render :json=>{:template=> render_to_string(:partial=>'delivery_people/delivery_form_values.html' ,:locals=>{:delivery_person=>@delivery_person, :form_values=>@form_values})}}
		end
	end

	def show
	end

	def new
		@delivery_person = DeliveryPerson.new
	end

	def create
		@delivery_person = DeliveryPerson.new(delivery_person_params)
		if @delivery_person.save
			flash[:success] = "#{@delivery_person.name} 新增成功"
			redirect_to admin_delivery_people_path
		else
			flash[:fail] = "#{@delivery_person.name} 新增失敗, #{@delivery_person.errors.full_messages}"
			render 'admin/delivery_people/new'
		end
	end

	def edit
	end

	def update
		if @delivery_person.update(delivery_person_params)
			flash[:success] = "#{@delivery_person.name} 更新成功"
			redirect_to admin_delivery_people_path
		else
			flash[:fail] = "#{@delivery_person.name} 更新失敗"
			render 'admin/delivery_people/edit'
		end
	end

	def destroy
		@delivery_person = DeliveryPerson.find(params[:id])
		if @delivery_person.destroy
			flash[:success] = "#{@delivery_person.name} 已被移除"
			redirect_to admin_delivery_people_path
		else
			flash[:fail] = "#{@delivery_person.name} 移除失敗"
			render 'admin/delivery_people/edit'
		end
	end

private
		
	def set_delivery_person
		@delivery_person = DeliveryPerson.includes(:form_values).find(params[:id])
	end

	def delivery_person_params
		params.require(:delivery_person).permit(:code,:name,:status,:user_id)
	end
end
