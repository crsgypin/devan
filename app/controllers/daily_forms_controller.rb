class DailyFormsController < ApplicationController
	before_action :authenticate_user!

	def index
		@daily_forms = DailyForm.includes(:form_values=>[:manufacturer,:delivery_person,:customer])
		@daily_forms = @daily_forms.page(params[:page]).per(15)

		@daily_form = @daily_forms.find_or_create_by(:date=> Date.today)
		set_form_values
		set_selection_list
		set_form_selection_list
	end

	def edit
		@daily_form = DailyForm.find(params[:id])
		set_form_values
		set_selection_list

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_edit.html",:locals=>{:daily_form=>@daily_form, :form_values=>@form_values})}}
		end
	end

	def show
		@daily_form = DailyForm.find(params[:id])
		set_form_values
		set_form_selection_list

		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_show.html",:locals=>{:daily_form=>@daily_form, :form_values=>@form_values})}}
		end
	end

	def update
		@daily_form = DailyForm.find(params[:id])

		index_id = {}
		if params[:data]
			params[:data][:form_values].each do |index,value|
				if value[:id] == "" || value[:id] == nil
					form_value = @daily_form.form_values.create
				else
					form_value = @daily_form.form_values.find(value[:id].to_i)
				end	

				FormValue.attribute_names.each do |a|
					form_value[a] = value[a] if value[a] && a!= "id"
				end
				index_id[index] = form_value.id #feedback index_id for browser to registor id into new row
				form_value.save!
				form_value.form_value_users.find_or_create_by(:user=>current_user)
			end
		end

		if params[:submit].to_i == 1
			set_form_values
			set_form_selection_list
			respond_to do |format|
				format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_show.html",:locals=>{:daily_form=>@daily_form, :form_values=>@form_values})}}
			end
		else
			respond_to do |format|
				format.json {render :json=>{:result=>index_id.to_json}}
			end
		end
	end

	def delete_form_value
		@form_value = FormValue.find(params[:id])
		@form_value.destroy
		respond_to do |format|
			format.json {render :json=>{:result=>"OK"}}
		end
	end

	def new_form_value
		@form_value = FormValue.new
		@index = params[:index].to_i

		set_selection_list
		respond_to do |format|
			format.json {render :json=>{:template=>render_to_string(:partial=>"daily_forms/form_values_edit_row.html",:locals=>{:form_value=>@form_value, :index=>@index})}}
		end
	end


private
	def set_form_values
		@form_values = @daily_form.form_values.joins(:form_value_users)
		@form_values = @form_values.where('form_value_users.user_id = ?', current_user.id)
		20.times do |index|
			if @form_values.length <= index
				@form_values << FormValue.new				
			end
		end

		@form_values
	end

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
		@customer_list = Customer.active.map{|c| {:id=>c.id, :text=> c.name}}
		@delivery_people_list = DeliveryPerson.on_job.map{|d| [d.name, d.id]}
		@manufacturer_list = Manufacturer.all.map{|m| [m.name, m.id]}
	end

end
