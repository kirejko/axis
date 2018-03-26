# frozen_string_literal: true

# List people
class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: %i[show]

  def index
    @people = User.includes(:profile).ordered.page.decorate
  end

  def show; end

  private

  def set_person
    @person = User.find(params[:id])
  end

end
