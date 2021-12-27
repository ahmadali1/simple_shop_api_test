require 'faker'

FactoryBot.define do
  factory :order do
    shipping_address { Faker::Address.full_address }
    paid_at { Time.now }
    status { Order.statuses[:unpaid] }
    price { 100 }

    # trait(:with_products_and_order_items) do
    #   before(:create) do |order|
    #     product1 = create(:product, price: 50, stock: 10)
    #     order.order_items.new(product: product1)

    #     product2 = create(:product, price: 50, stock: 100)
    #     order.order_items.new(product: product2)
    #   end
    # end
  end
end
