FactoryBot.define do
  factory :tenant do
    name { Faker::Name.name }
    api_key { SecureRandom.hex }
  end
end