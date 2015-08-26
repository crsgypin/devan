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

	def day_list
		return [{eng: "monday", ch:"星期一"},
						{eng: "tuesday", ch: "星期二"},
						{eng: "wednesday", ch: "星期三"},
						{eng: "thursday", ch: "星期四"},
						{eng: "friday", ch: "星期五"},
						{eng: "saturday", ch: "星期六"},
						{eng: "sunday", ch: "星期日"},
						{eng: "unstable_day", ch: "不固定"}
						]
	end

	def weekday_list
		return %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
	end

	def before_day(days)
		 days.day.ago.strftime('%m/%d')
	end

	def before_week_day(days)
		days.day.ago.strftime('%A')
	end

	def setup_customer(customer)
		customer.build_customer_delivery_day unless customer.customer_delivery_day
		customer
	end

end
