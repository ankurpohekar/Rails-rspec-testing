class EmployeesController < ApplicationController

  before_action :get_employee, only: [:show, :edit, :update, :destroy]

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee
    else
      render :new
    end
  end

  def index
    @employees = Employee.all
  end

  def show
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
    	render :edit
    end
  end

  def destroy
    if @employee.destroy
      redirect_to employees_path
    end
  end

  private

  def get_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :age, :emp_id)
  end

end
