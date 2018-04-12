# frozen_string_literal: true

module Admin
  # User related functionality
  class UsersController < AdminController
    before_action :set_user, only: %i[edit update destroy]

    def index
      @users = User.includes(:profile).ordered.page(params[:page]).decorate
    end

    def new
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
      @form = Admin::EditUserProfileForm.new(@user)
    end

    def update
      authorize @user, :update?

      @form = Admin::EditUserProfileForm.new(@user, update_user_params)
      if @form.update
        redirect_to admin_users_url, notice: t('admin.user.messages.update.success')
      else
        render :edit
      end
    end

    def destroy
      authorize @user, :destroy?

      # @user.destroy!
      render json: { message: t('admin.user.messages.delete.success'), status: :deleted }
    end

    private

    def set_user
      @user = User.includes(:profile).find(params[:id])
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

    def update_user_params
      params.require(:profile).permit(%i[
        avatar email password password_confirmation
        first_name middle_name last_name
        position department remote_worker remote_hourly
        trial_at hired_at fired_at
        gmail skype phone1 phone2
        gender birthday notes
      ])
    end

  end
end


