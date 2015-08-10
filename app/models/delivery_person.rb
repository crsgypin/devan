class DeliveryPerson < ActiveRecord::Base
	validates_inclusion_of :status, :in => %w( 在職 離職 ), :message => "狀態需填寫'在職'或'離職'"
	validates_uniqueness_of :code, :message => "編號衝突"

	has_many :form_values
	belongs_to :user
	delegate :email, :to=> :user, :prefix=>true, :allow_nil=>true

end
