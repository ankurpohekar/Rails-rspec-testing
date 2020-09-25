class Employee < ApplicationRecord
  validates_presence_of :first_name, :age, :emp_id
  validates_uniqueness_of :emp_id
  validates_length_of :first_name, minimum: 1, maximum: 255
end
