class Admin::CitiesController < ApplicationController
	before_action :set_city, :only=>[:show,:edit,:update,:destroy]
	before_action :authenticate_user!

	def index
		@cities = City.all
	end

	def show
	end

	def new
		@city = City.new
	end

	def create
		@city = City.new(city_params)
		if @city.save
			flash[:success] = "#{@city.name} 新增成功"
			redirect_to city_path(@city)
		else
			flash[:fail] = "#{@city.name} 新增失敗"
			render 'cities/new'
		end
	end

	def edit
	end

	def update
		if @city.update(city_params)
			flash[:success] = "#{@city.name} 更新成功"
			redirect_to city_path(@city)
		else
			flash[:fail] = "#{@city.name} 更新失敗"
			render 'cities/edit'
		end
	end

	def destroy
		@city = City.find(params[:id])
		if @city.destroy
			flash[:success] = "#{@city.name} 已被移除"
			redirect_to cities_path
		else
			flash[:fail] = "#{@city.name} 移除失敗"
			render 'cities/show'
		end
	end

private
	
	def set_city
		@city = City.find(params[:id])
	end

	def city_params
		params.require(:city).permit(:name)
	end

end
