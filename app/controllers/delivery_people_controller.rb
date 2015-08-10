class DeliveryPeopleController < ApplicationController
	before_action :set_delivery_person, :only=>[:show,:edit,:update,:destroy]

	def index
		@delivery_people = DeliveryPerson.all
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
			redirect_to delivery_person_path(@delivery_person)
		else
			flash[:fail] = "#{@delivery_person.name} 新增失敗"
			render 'delivery_people/new'
		end
	end

	def edit
	end

	def update
		if @delivery_person.update(delivery_person_params)
			flash[:success] = "#{@delivery_person.name} 更新成功"
			redirect_to delivery_person_path(@delivery_person)
		else
			flash[:fail] = "#{@delivery_person.name} 更新失敗"
			render 'delivery_people/edit'
		end
	end

	def destroy
		@delivery_person = DeliveryPerson.find(params[:id])
		if @delivery_person.destroy
			flash[:success] = "#{@delivery_person.name} 已被移除"
			redirect_to delivery_people_path
		else
			flash[:fail] = "#{@delivery_person.name} 移除失敗"
			render 'delivery_people/show'
		end
	end

private
		
	def set_delivery_person
		@delivery_person = DeliveryPerson.find(params[:id])
	end

	def delivery_person_params
		params.require(:delivery_person).permit(:code,:name,:status,:user_id)
	end
end
