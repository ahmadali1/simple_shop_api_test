require 'faker'

FactoryBot.define do
  factory :product do
    title { Faker::Book.title }
    description { Faker::String.random }
    price { Faker::Number.number }
    sku { Faker::Name.unique.name }
    stock { 5 }

    trait(:with_region) do
      before(:create) do |product|
        product.region = create(:region, admin: create(:user))
      end
    end
  end
end
