class FormValueUser < ActiveRecord::Base
	belongs_to :form_value_user_link, :polymorphic => true	
	belongs_to :user

end
