FactoryBot.define do
  factory :answer do
    association :question
    association :user
    body { Faker::Lorem.paragraph }
  end
end