# frozen_string_literal: true

# User related functionality
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.includes(:profile).ordered.page(params[:page]).decorate
  end

  def show
    @user.decorates
  end

  def new
    @user = User.new
    @user.build_profile
    authorize @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, success: 'User has been created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, success: 'User has been updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, success: 'User has been deleted'
  end

  private

  def set_user
    @user = User.find_by :id, params[:id]
    authorize @user
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :avatar,
      profile_attributes: %i[
        id first_name middle_name last_name
        gender birthday moto bio
        gmail skype phone1 phone2
        position remote_worker remote_hourly
        trial_at hired_at
      ]
    )
  end
end
