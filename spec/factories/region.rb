require 'faker'

FactoryBot.define do
  factory :region do
    title { Faker::FunnyName.name }
    tax { 10.00 }
    country { 'PAKISTAN' }
    currency { 'PKR' }
  end
end
