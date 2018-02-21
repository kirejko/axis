# frozen_string_literal: true

# Main admin application controller
class AdminController < ApplicationController
  before_action :ensure_admin

  private

  def ensure_admin
    authenticate_user!
    raise ActionController::RoutingError, 'Not Found' unless current_user.admin?
  end
end
