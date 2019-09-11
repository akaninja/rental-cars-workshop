FactoryBot.define do
  factory :car_model do
    sequence(:name) {|n| "Palio#{n}" }
    year { '2008' }
    manufacture
    car_options { '3 portas' }
  end
end
