FactoryBot.define do
  factory :user do
    first_name { "Daniel" }
    last_name { "Doe" }
    sequence :email do |n|
      "daniel#{n}@email.com"
    end
    password { "password" }
  end
end
