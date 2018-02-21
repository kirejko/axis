# frozen_string_literal: true

module Admin
  # Departments management
  class DepartmentsController < AdminController
    before_action :set_department

    def index; end

    def new; end

    def create; end

    def edit; end

    def update; end

    def destroy; end

    private

    def set_department
      @department = Department.find(params[:id])
    end
  end
end
