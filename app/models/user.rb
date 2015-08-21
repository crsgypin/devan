class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :delivery_person
  has_many :form_value_users
  has_many :form1_values, :through=>:form_value_users, :source=>:form_value_user_link, :source_type=>"Form1Value"
  has_many :form2_values, :through=>:form_value_users, :source=>:form_value_user_link, :source_type=>"Form2Value"

  def display_name
  	if self.username.present?
  		return self.username
  	elsif self.name.present?
  		return self.name
  	else
  		return self.email.split('@').first
  	end
  end

  def form1_value_users
    self.form_value_users.where(:form_value_user_link_type=>"Form1Value")
  end

  def form2_value_users
    self.form_value_users.where(:form_value_user_link_type=>"Form2Value")
  end


end
