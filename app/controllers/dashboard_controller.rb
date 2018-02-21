# frozen_string_literal: true

# Main user dashboard
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
