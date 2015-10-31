class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActionController::ParameterMissing, with: :render_422

  private

  def render_422
    render json: { error: 'Parameter missing!' }, status: :unprocessable_entity
  end

  def authenticate
    return true unless Rails.env.production?
    authenticate_or_request_with_http_basic('FooBar') do |username, password|
      username == ENV['HTTP_AUTHENTICATION_LOGIN'] && password == ENV['HTTP_AUTHENTICATION_PASSWORD']
    end
  end
end
