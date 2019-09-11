FactoryBot.define do
  factory :manufacture do
    sequence(:name) {|z| "Fiat#{z}" }
  end
end
