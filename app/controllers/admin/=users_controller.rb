# frozen_string_literal: true

# User related functionality
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]

  # get '/users'
  def index
    @users = User.includes(:profile).ordered.page(params[:page]).decorate
  end

  # get '/users/:id'
  def show
    @user.decorate
  end

  # get '/users/new'
  def new
    authorize User.new, :create?

    @form = UserForms::Registration.new
  end

  # post '/users'
  def create
    authorize User.new, :create?

    @form = UserForms::Registration.new(create_user_params)
    if @form.save
      redirect_to users_url, success: 'User has been created'
    else
      render :new
    end
  end

  # get '/users/:id/edit'
  def edit; end

  # put|patch '/users/:id'
  def update
    # if @user.update(user_params)
    #   redirect_to @user, success: 'User has been updated.'
    # else
    #   render :edit
    # end
  end

  # delete '/users/:id'
  def destroy
    # @user.destroy
    # redirect_to users_url, success: 'User has been deleted'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def create_user_params
    params.require(:register).permit(%i[
      avatar email password password_confirmation
      first_name middle_name last_name
      position remote_worker remote_hourly
      trial_at hired_at
      gmail skype phone1 phone2
      gender birthday notes
    ])
  end
end
