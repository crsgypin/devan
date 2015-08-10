module ApplicationHelper

	def city_district_list
		list = {}
		City.all.each do |city|

			districts = []
			city.districts.each_with_index do |district|
				districts << {:id=>district.id,:name=>district.name}
			end
			list[city.id] = districts
		end

		list.to_json
	end

end
