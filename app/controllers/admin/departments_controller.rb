# frozen_string_literal: true

module Admin
  # Departments management
  class DepartmentsController < AdminController
    before_action :set_department, only: %i[edit update destroy]

    # get '/admin/departments'
    def index
      @departments = Department.page(params[:page]).decorate
    end

    # get '/admin/departments/new'
    def new
      authorize Department, :create?

      @form = Admin::DepartmentForm.new(department: Department.new)
    end

    # post '/admin/departments'
    def create
      authorize Department, :create?

      @form = Admin::DepartmentForm.new(attributes: request_params)
      if @form.save
        redirect_to admin_departments_url, notice: 'Department has been created'
      else
        render :new
      end
    end

    # get '/admin/departments/:id/edit'
    def edit
      authorize @department, :update?

      @form = Admin::DepartmentForm.new(department: @department)
    end

    # put|patch '/admin/departments/:id'
    def update
      authorize @department, :update?

      @form = Admin::DepartmentForm.new(department: @department, attributes: request_params)
      if @form.update
        redirect_to admin_departments_url, success: 'Department has been updated'
      else
        render :edit
      end
    end

    # delete '/admin/departments/:id'
    def destroy
      authorize @department, :destroy?

      @department.destroy
      render json: { status: 'success', message: 'Department has been deleted' }.compact, status: 200
    end

    private

    def set_department # :nodoc:
      @department = Department.find(params[:id])
    end

    def request_params # :nodoc:
      params.require(:department).permit(:name, :description)
    end
  end
end
