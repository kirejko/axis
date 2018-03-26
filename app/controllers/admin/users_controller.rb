# frozen_string_literal: true

module Admin
  # User related functionality
  class UsersController < AdminController
    before_action :set_user, only: %i[edit update destroy]

    def index
      @users = User.includes(:profile).ordered.page.decorate
    end

    def new
      authorize User, :create?

      @form = Admin::UserRegistrationForm.new
    end

    def create
      authorize User, :create?

      @form = Admin::UserRegistrationForm.new(create_user_params)
      if @form.save
        redirect_to admin_users_url, notice: t('admin.user.messages.create.success')
      else
        render :new
      end
    end

    def edit
      authorize User, :udpate?
    end

    def update
      authorize User, :udpate?
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def create_user_params
      params.require(:register).permit(%i[
      avatar email password password_confirmation
      first_name middle_name last_name
      position department remote_worker remote_hourly
      trial_at hired_at
      gmail skype phone1 phone2
      gender birthday notes
    ])
    end

  end
end


