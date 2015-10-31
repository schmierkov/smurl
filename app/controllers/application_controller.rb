class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActionController::ParameterMissing, with: :render_422

  private

  def render_422
    render json: { error: 'Parameter missing!' }, status: :unprocessable_entity
  end
end
