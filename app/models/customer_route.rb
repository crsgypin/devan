class CustomerRoute < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  
	belongs_to :customer
	belongs_to :delivery_person


end
