# frozen_string_literal: true

# Main admin application controller
class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  private

  def ensure_admin
    raise ActionController::RoutingError, 'Not Found' unless current_user.admin?
  end
end
