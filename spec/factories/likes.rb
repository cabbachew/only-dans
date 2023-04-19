FactoryBot.define do
  factory :like do
    user { nil }
    post { nil }
    comment { nil }
    state { 1 }
  end
end
