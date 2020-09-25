FactoryBot.define do
  factory :employee do
    first_name { "John" }
    age {30}
    sequence(:emp_id) { |n| "emp#{n}" }
  end
end
