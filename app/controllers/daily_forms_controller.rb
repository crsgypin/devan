class DailyFormsController < ApplicationController
	before_action :authenticate_user!, :except=>[:index,:show]
	layout "form_print", only: [:print]

	def index
		@daily_forms = DailyForm.includes(:form_values=>[:manufacturer,:delivery_person,:customer])
		@daily_forms = @daily_forms.page(params[:page]).per(15)

		@daily_form = @daily_forms.find_or_create_by(:date=> Date.today)
		@form_values = @daily_form.form_values

		20.times do |index|
			if @daily_form.form_values.length <= index
				@daily_form.form_values.new				
			end

		end
		set_selection_list
		set_form_selection_list
	end

	def update_form
		@daily_form = DailyForm.find(params[:id])

		index_id = {}
		if params[:data]
			params[:data][:form_values].each do |index,value|
				if value[:id] == "" || value[:id] == nil
					form_value = @daily_form.form_values.create
				else
					form_value = @daily_form.form_values.find(value[:id].to_i)
				end	

				formValue.attribute_names.each do |a|
					form_value[a] = value[a] if value[a] && a!= "id"
				end
				index_id[index] = form_value.id #feedback index_id for browser to registor id into new row
				form_value.save!
				form_value.form_value_users.find_or_create_by(:user=>current_user)
			end
		end

		if params[:submit].to_i == 1
			@form_values = @daily_form.form_values
			set_form_selection_list
			20.times do |index|
				if @daily_form.form_values.length <= index
					@daily_form.form_values.new				
				end
			end
			respond_to do |format|
				format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_show.html",:locals=>{:daily_form=>@daily_form, :form_values=>@form_values})}}
			end
		else
			respond_to do |format|
				format.json {render :json=>{:result=>index_id.to_json}}
			end
		end
	end

	def edit_form

		@daily_form = DailyForm.find(params[:id])
		@form_values = @daily_form.form_values					

		20.times do |index|
			if @daily_form.form_values.length <= index
				@daily_form.form_values.new				
			end
		end

		set_selection_list

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_edit.html",:locals=>{:daily_form=>@daily_form, :form_values=>@form_values})}}
		end

	end

	def show_form
		@daily_form = DailyForm.find(params[:id])
		@form_values = @daily_form.form_values
		20.times do |index|
			if @daily_form.form_values.length <= index
				@daily_form.form_values.new				
			end
		end

		set_form_selection_list

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_show.html",:locals=>{:daily_form=>@daily_form, :form_values=>@form_values})}}
		end
	end

	def delete_form_value
		@form_value = formValue.find(params[:id])
		@form_value.destroy
		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

	def new_form_value
		@form_value = formValue.new
		@index = params[:index].to_i

		set_selection_list
		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_edit_row.html",:locals=>{:form_value=>@form_value, :index=>@index})}}
		end
	end


private
	def set_form_selection_list
		@form_list = DailyForm.first(10).map do |daily_form|
			if daily_form.date == Date.today
			  ["今天(#{daily_form.date.strftime('%m月%d日')})",daily_form.id]
			else
			  [daily_form.date.strftime('%m月%d日'), daily_form.id]	
			end
		end
	end

	def set_selection_list
		@customer_list = Customer.active.map{|c| {:id=>c.id, :text=>"#{c.code}-#{c.name}"}}
		@delivery_people_list = DeliveryPerson.on_job.map{|d| ["#{d.code}-#{d.name}", d.id]}
		@manufacturer_list = Manufacturer.all.map{|m| [m.name, m.id]}
	end

end
