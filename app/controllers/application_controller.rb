class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActionController::ParameterMissing, with: :redirect_to_root

  private

  def redirect_to_root
    redirect_to root_url
  end
end
