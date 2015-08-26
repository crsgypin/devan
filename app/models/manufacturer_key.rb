class ManufacturerKey < ActiveRecord::Base
	belongs_to :manufacturer

	before_save :check_key_mapping

private
	def check_key_mapping
		key = ManufacturerKey.find_by(:manufacturer=> self.manufacturer, :mapping_key=> self.mapping_key)
		if key != nil && key != self
			return false
		end
	end
end
