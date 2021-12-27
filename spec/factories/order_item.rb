require 'faker'

FactoryBot.define do
  factory :order_item do
    order_id { 1 }
    product_id { 1 }
    quantity { 1 }
  end
end
