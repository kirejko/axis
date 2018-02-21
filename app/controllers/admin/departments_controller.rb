# frozen_string_literal: true

module Admin
  # Departments management
  class DepartmentsController < AdminController
    before_action :set_department, only: %i[edit destroy]

    # get '/admin/departments'
    def index
      @departments = Department.all.page(params[:page]).decorate
    end

    # get '/admin/departments/new'
    def new
      @form = Forms::Admin::Department.new
    end

    # post '/admin/departments'
    def create
      @form = Forms::Admin::Department.new(attributes: request_params)
      if @form.save
        redirect_to admin_departments_path, success: 'Department has been created'
      else
        render :new
      end
    end

    # get '/admin/departments/:id/edit'
    def edit
      @form = Forms::Admin::Department.new(department: @department)
    end

    # put|patch '/admin/departments/:id'
    def update
      @form = Forms::Admin::Department.new(department: @department, attributes: request_params)
      if @form.update
        redirect_to admin_departments_path, success: 'Department has been updated'
      else
        render :edit
      end
    end

    # delete '/admin/departments/:id'
    def destroy
      @department.destroy
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
