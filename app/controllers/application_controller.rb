class ApplicationController < ActionController::Base
  before_action :set_raven_context
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def authenticate_user
    if session[:user_id]
      return true
    else
      redirect_to signin_path, flash: { success: 'Please sign in' }
      false
    end
  end

  private

  def not_found
    render nothing: true, status: :not_found
  end

  def order_param
    order = params[:order] || '-updated_at'
    { 'name' => 'name ASC',
      '-name' => 'name DESC',
      'updated_at' => 'updated_at ASC',
      '-updated_at' => 'updated_at DESC' }[order]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
