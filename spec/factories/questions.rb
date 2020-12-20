FactoryBot.define do
  factory :question do
    association :user
    title { Faker::Movie.title }
    private { false }

    factory :private_question do
      private { true }
    end
  end
end