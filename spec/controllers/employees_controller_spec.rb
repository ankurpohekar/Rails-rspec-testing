require 'rails_helper'

describe EmployeesController do

  describe 'GET #index' do
    it 'populates an array of employee and renders the index template' do
      employee = FactoryBot.create(:employee)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested employee and renders the :show template' do
      employee = FactoryBot.create(:employee)
      get :show, params: { id: employee }, flash: { notice: "This is a flash message" }, session: nil
      expect(assigns(:employee)).to eq(employee)
      expect(response).to render_template('show')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new employee in the database and redirects to the show page' do
        expect do
        post :create, employee: FactoryBot.build(:employee).attributes
        end.to change(Employee, :count).by(1)
        expect(response).to redirect_to(employee_path(Employee.last))
      end
    end

    context 'with first_name not present' do
      it 'does not save the new employee in the database and re-renders the new template ' do
        expect do
          post :create, employee: FactoryBot.build(:employee, first_name: nil, age: 30, emp_id: "emp_id-1").attributes
        end.to_not change(Employee, :count)
        expect(response).to render_template('new')
      end
    end

    context 'with age not present' do
      it 'does not save the new employee in the database and re-renders the new template ' do
        expect do
          post :create, employee: FactoryBot.build(:employee, first_name: "Test", emp_id: "emp_id-2", age: nil).attributes
        end.to_not change(Employee, :count)
        expect(response).to render_template('new')
      end
    end

    context 'with emp_id not present' do
      it 'does not save the new employee in the database and re-renders the new template ' do
        expect do
          post :create, employee: FactoryBot.build(:employee, first_name: "Test", age: 30, emp_id: nil).attributes
        end.to_not change(Employee, :count)
        expect(response).to render_template('new')
      end
    end
  end
  describe 'PUT update' do
    let(:employee) { create(:employee) }
    let(:params) do
      attributes_for(:employee,
                     first_name: 'Test', last_name: "Test", age: 30, emp_id: "emp_12jh7")
    end

    context 'valid attributes' do
      it 'updated the requested employee' do
        put :update, id: employee.id, employee: params
        expect(assigns(:employee)).to eq(employee)
        employee.reload
        expect(employee.first_name).to eq params[:first_name]
        expect(employee.last_name).to eq params[:last_name]
        expect(employee.age).to eq params[:age]
        expect(employee.emp_id).to eq params[:emp_id]
        expect(response).to redirect_to employee
      end
    end

    context 'with first_name not present' do
      it 're-renders the edit method' do
        put :update, id: employee.id, employee: params.merge!(first_name: nil)
        expect(assigns(:employee)).to eq(employee)
        employee.reload
        employee.first_name.should_not be_nil
        expect(response).to render_template :edit
      end
    end

    context 'with age not present' do
      it 're-renders the edit method' do
        put :update, id: employee.id, employee: params.merge!(age: nil)
        expect(assigns(:employee)).to eq(employee)
        employee.reload
        employee.age.should_not be_nil
        expect(response).to render_template :edit
      end
    end

    context 'with emp_id not present' do
      it 're-renders the edit method' do
        put :update, id: employee.id, employee: params.merge!(emp_id: nil)
        expect(assigns(:employee)).to eq(employee)
        employee.reload
        employee.emp_id.should_not be_nil
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:employee) { create(:employee) }
    it 'deletes the employee' do
      expect { delete :destroy, id: employee.id }.to change(Employee, :count).by(-1)
      expect(response).to redirect_to employees_url
    end
  end
end
