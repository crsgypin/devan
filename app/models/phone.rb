class Phone < ActiveRecord::Base
	belongs_to :phone_link, :polymorphic => true

end
