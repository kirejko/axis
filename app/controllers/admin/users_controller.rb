# frozen_string_literal: true

module Admin
  # User related functionality
  class UsersController < AdminController
    before_action :set_user, only: %i[edit update destroy]

    def index
      @users = User.includes(:profile).ordered.page(params[:page]).decorate
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

  end
end


