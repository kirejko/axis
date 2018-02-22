# frozen_string_literal: true

# Main admin application controller
class AdminController < ApplicationController
  before_action :authenticate_user!

  # private
  #
  # def ensure_admin
  #   raise ActionController::RoutingError, 'Not Found' unless current_user.admin?
  # end
end
