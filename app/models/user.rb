class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :delivery_person

  def display_name
  	if self.username.present?
  		return self.username
  	elsif self.name.present?
  		return self.name
  	else
  		return self.email.split('@').first
  	end
  end

end
