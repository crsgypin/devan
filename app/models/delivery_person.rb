class DeliveryPerson < ActiveRecord::Base
	validates_inclusion_of :status, :in => %w( 在職 離職 ), :message => "狀態需填寫'在職'或'離職'"
	validates_uniqueness_of :code, :message => "編號衝突"

	has_many :form_values
	has_many :customer_routes
	belongs_to :user
	delegate :email, :to=> :user, :prefix=>true, :allow_nil=>true
	before_destroy :check_form_values

	def recent_form_values(day_count)
		self.form_values.includes(:daily_form,:customer).joins(:daily_form).where("date >= ?",Date.today - day_count.days).order('daily_forms.date desc')
	end

	def self.on_job
		self.where(:status=>"在職")
	end

private
	def check_form_values
		if self.form_values.count >0
			return false
		end
	end
end
