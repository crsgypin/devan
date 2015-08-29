class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def mobile_device?
		return (request.user_agent.downcase =~ /mobile|iphone|android/) ? true : false
  end

  helper_method :mobile_device?
end
