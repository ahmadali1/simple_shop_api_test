require 'faker'

FactoryBot.define do
  factory :store do
    name { Faker::FunnyName.name }
  end
end
