require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { build(:employee) }
  

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:emp_id) }

  
  it 'is invalid without a first_name' do
    employee.first_name = nil
    employee.valid?
    expect(employee.errors.messages[:first_name]).to include("can't be blank")
  end

  it 'is valid without a last_name' do
    employee.last_name = nil
    employee.valid?
    expect(employee.valid?).to be true
  end

  it 'is invalid for first_name exceeding 255 characters' do
    employee.first_name = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
    employee.valid?
    expect(employee.errors.messages[:first_name]).to include('is too long (maximum is 255 characters)')
  end

  it 'is invalid for first_name less then 1 characters' do
    employee.first_name = ''
    employee.valid?
    expect(employee.errors.messages[:first_name]).to include("is too short (minimum is 1 character)")
  end

  it 'is invalid without a age' do
    employee.age = nil
    employee.valid?
    expect(employee.errors.messages[:age]).to include("can't be blank")
  end

  it 'is invalid without a emp_id' do
    employee.emp_id = nil
    employee.valid?
    expect(employee.errors.messages[:emp_id]).to include("can't be blank")
  end

  it 'is invalid with duplicate emp_id' do
    employee.save
    employee1 = build(:employee)
    employee1.emp_id = employee.emp_id
    employee1.valid?
    expect(employee1.errors.messages[:emp_id]).to include('has already been taken')
  end
end
