# frozen_string_literal: true

# User related functionality
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.includes(:profile).page(params[:page]).decorate
  end

  def show
    @user.decorate
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    @user.build_profile(user_params[:profile_attributes])
    if @user.save
      redirect_to @user, success: 'User has been created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(article_params)
      redirect_to @user, success: 'User has been updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to people_url, success: 'User has been deleted'
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, profile_attributes: %i[
        first_name last_name middle_name avatar birthday
      ]
    )
  end
end
