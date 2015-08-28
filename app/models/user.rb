class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :delivery_person
  has_one :permission, :dependent =>:destroy
  accepts_nested_attributes_for :permission, allow_destroy: true

  has_many :form_value_users
  has_many :form_values, :through=>:form_value_users

  before_create :set_permission

  def display_name
  	if self.username.present?
  		return self.username
  	elsif self.name.present?
  		return self.name
  	else
  		return self.email.split('@').first
  	end
  end

  def self.without_delivery_person
    return User.all - User.joins(:delivery_person)
  end

  def member?
    return self.permission.member
  end

  def editor?
    return self.permission.editor
  end

  def admin?
    return self.permission.admin
  end

private
  def set_permission
    p = self.build_permission
    Permission.columns.map do |c|
      if c.type == :boolean
        p[c.name] = false
      end
    end
  end
end



