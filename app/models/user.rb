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

  before_create :create_permission

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

#permission
  def edit_form?
    return self.permission.edit_form
  end

  def edit_setting?
    return self.permission.edit_setting
  end

  def edit_permission?
    return self.permission.edit_permission
  end

  def status
    if self.permission.edit_permission
      return "admin"
    elsif self.permission.edit_setting
      return "editor"
    elsif self.permission.edit_form
      return "member"
    else
      return "guest"
    end
  end

  def status=(status)
    if status == "guest"
      set_permission(false,false,false)
    elsif status == "member"
      set_permission(true,false,false)
    elsif status == "editor"
      set_permission(true,true,false)
    elsif status == "admin"
      set_permission(true,true,true)
    end
  end

  def self.status_list
    return ["guest","member","editor","admin"]
  end

private
  def create_permission
    p = self.build_permission
    self.status="guess"
  end

  def set_permission(form,setting,permission)
    self.permission.edit_form = form
    self.permission.edit_setting = setting
    self.permission.edit_permission = permission
  end
end



