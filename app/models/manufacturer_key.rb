class ManufacturerKey < ActiveRecord::Base
	belongs_to :manufacturer

	before_save :check_key_mapping

private
	def check_key_mapping
		

	end
end
