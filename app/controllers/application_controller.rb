class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  append_before_action :set_locale

  include Pundit

  # Rescues
  rescue_from Pundit::NotAuthorizedError,     with: :user_not_authorized
  rescue_from Exception,                      with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404

  def raise_not_found
    raise ActionController::RoutingError, 'Page not found'
  end

  def pundit_user
    AuthContext.new(current_user)
  end

  private

  def set_locale
    I18n.locale = current_user.try(:locale) || I18n.default_locale
  end

  def user_not_authorized
    flash[:danger] = 'You are not authorized to perform this action.'
    redirect_to request.referrer || root_path
  end

  def render_404
    render 'errors/404'
  end

  def render_500(error)
    return raise error if Rails.env.development?

    Rails.logger.error error.message
    Rails.logger.error error.backtrace.join("\n")

    render 'errors/500'
  end
end
