class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception, with: :render_error unless Rails.env.development?

  private 
  	def render_error
  		Rails.logger.info("into render_error")
  		redirect_to root_path
  	end
end
