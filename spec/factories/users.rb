FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "jose#{n}@gmail.com" }
    password { '12345678' }
    subsidiary
    role { :employee }

    trait :manager do
      role { :manager }
    end

    trait :admin do
      role { :admin }
    end
  end
end
