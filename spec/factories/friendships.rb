FactoryBot.define do
  factory :friendship do
    from_friend { create(:user) }
    to_friend { create(:user) }

    trait :accepted do
      accepted_at { Time.current }
    end
  end
end
