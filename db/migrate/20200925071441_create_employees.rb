class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :first_name,   limit: 255, null: false
      t.string :last_name,    limit: 255
      t.integer :age,         limit: 8,   null: false
      t.string :emp_id,       limit: 255, null: false

      t.timestamps
    end
  end
end
