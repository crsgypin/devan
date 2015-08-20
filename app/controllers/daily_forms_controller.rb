class DailyFormsController < ApplicationController
	before_action :authenticate_user!, :except=>[:index,:show]
	layout "form_print", only: [:print]

	def index
		@daily_forms = DailyForm.includes(:form1_values=>[:manufacturer,:delivery_person,:customer])
		@daily_forms = @daily_forms.includes(:form2_values=>[:manufacturer,:delivery_person,:customer])
		@daily_forms = @daily_forms.page(params[:page]).per(15)

		@daily_form = @daily_forms.find_or_create_by(:date=> Date.today)
		@form1_values = @daily_form.form1_values
		@form2_values = @daily_form.form2_values

		20.times do |index|
			if @daily_form.form1_values.length <= index
				@daily_form.form1_values.new				
			end

			if @daily_form.form2_values.length <= index
				@daily_form.form2_values.new				
			end
		end
		set_selection_list
	end

	def update_form1
		@daily_form = DailyForm.find(params[:id])

		index_id = {}
		if params[:data]
			params[:data][:form1_values].each do |index,value|
				if value[:id] == "" || value[:id] == nil
					form1_value = @daily_form.form1_values.create
				else
					form1_value = @daily_form.form1_values.find(value[:id].to_i)
				end	

				Form1Value.attribute_names.each do |a|
					form1_value[a] = value[a] if value[a] && a!= "id"
				end
				index_id[index] = form1_value.id #feedback index_id for browser to registor id into new row
				form1_value.save!
				form1_value.form_value_users.find_or_create_by(:user=>current_user)
			end
		end

		if params[:submit].to_i == 1
			@form1_values = @daily_form.form1_values		
			20.times do |index|
				if @daily_form.form1_values.length <= index
					@daily_form.form1_values.new				
				end
			end
			respond_to do |format|
				format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form1_values_show.html",:locals=>{:daily_form=>@daily_form, :form1_values=>@form1_values})}}
			end
		else
			respond_to do |format|
				format.json {render :json=>{:result=>index_id.to_json}}
			end
		end
	end

	def edit_form1

		@daily_form = DailyForm.find(params[:id])
		@form1_values = @daily_form.form1_values					

		20.times do |index|
			if @daily_form.form1_values.length <= index
				@daily_form.form1_values.new				
			end
		end

		set_selection_list

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form1_values_edit.html",:locals=>{:daily_form=>@daily_form, :form1_values=>@form1_values})}}
		end

	end

	def show_form1
		@daily_form = DailyForm.find(params[:id])
		@form1_values = @daily_form.form1_values					

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form1_values_show.html",:locals=>{:daily_form=>@daily_form, :form1_values=>@form1_values})}}
		end

	end

	def delete_form1_value
		@form1_value = Form1Value.find(params[:id])
		@form1_value.destroy
		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

	def new_form1_value
		@form1_value = Form1Value.new
		@index = params[:index].to_i

		set_selection_list
		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form1_values_edit_row.html",:locals=>{:form1_value=>@form1_value, :index=>@index})}}
		end
	end

	def update_form2
		@daily_form = DailyForm.find(params[:id])

		index_id = {}
		if params[:data]
			params[:data][:form2_values].each do |index,value|
				if value[:id] == "" || value[:id] == nil
					form2_value = @daily_form.form2_values.create
				else
					form2_value = @daily_form.form2_values.find(value[:id].to_i)
				end	

				Form2Value.attribute_names.each do |a|
					form2_value[a] = value[a] if value[a] && a!= "id"
				end
				index_id[index] = form2_value.id #feedback index_id for browser to registor id into new row
				form2_value.save!
				form2_value.form_value_users.find_or_create_by(:user=>current_user)
			end
		end

		if params[:submit].to_i == 1
			@form2_values = @daily_form.form2_values		
			20.times do |index|
				if @daily_form.form2_values.length <= index
					@daily_form.form2_values.new				
				end
			end
			respond_to do |format|
				format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form2_values_show.html",:locals=>{:daily_form=>@daily_form, :form2_values=>@form2_values})}}
			end
		else
			respond_to do |format|
				format.json {render :json=>{:result=>index_id.to_json}}
			end
		end
	end



	def edit_form2

		@daily_form = DailyForm.find(params[:id])
		@form2_values = @daily_form.form2_values					

		20.times do |index|
			if @daily_form.form2_values.length <= index
				@daily_form.form2_values.new				
			end
		end

		set_selection_list

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form2_values_edit.html",:locals=>{:daily_form=>@daily_form, :form2_values=>@form2_values})}}
		end

	end

	def show_form2
		@daily_form = DailyForm.find(params[:id])
		@form2_values = @daily_form.form2_values					

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form2_values_show.html",:locals=>{:daily_form=>@daily_form, :form2_values=>@form2_values})}}
		end

	end

	def delete_form2_value
		@form2_value = Form2Value.find(params[:id])
		@form2_value.destroy
		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

	def new_form2_value
		@form2_value = Form2Value.new
		@index = params[:index].to_i

		set_selection_list
		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form2_values_edit_row.html",:locals=>{:form2_value=>@form2_value, :index=>@index})}}
		end
	end


private
	def set_selection_list
		@customer_list = Customer.active.map{|c| {:id=>c.id, :text=>"#{c.code}-#{c.name}"}}
		@delivery_people_list = DeliveryPerson.on_job.map{|d| ["#{d.code}-#{d.name}", d.id]}
		@manufacturer_list = Manufacturer.all.map{|m| [m.name, m.id]}
	end

end
