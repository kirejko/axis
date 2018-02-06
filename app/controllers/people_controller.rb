# frozen_string_literal: true

# User related functionality
class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: %i[show update destroy]

  def index
    @people = User.includes(:profile).page(params[:page]).decorate
  end

  def show
    @person
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User has been created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(article_params)
      redirect_to @user, notice: 'User has been updated.'
    else
      render :edit
    end

  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User has been deleted'
  end

  private

  def set_person
    @person = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
