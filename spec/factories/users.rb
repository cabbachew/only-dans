FactoryBot.define do
  factory :user do
    first_name { "Daniel" }
    sequence :last_name do |n|
      "Doe#{n}"
    end
    sequence :email do |n|
      "daniel#{n}@email.com"
    end
    password { "password" }
  end
end
