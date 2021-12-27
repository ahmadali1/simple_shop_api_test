class Order < ApplicationRecord
  enum status: { unpaid: 0, paid: 1, cancelled: 2 }

  belongs_to :customer, class_name: 'User', foreign_key: :user_id
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # TODO: can apply validation if order can not be created without order items
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  after_save :make_payment

  def calculate_price!
    order_items && update(price: order_items.sum(:total_price)) # TODO: Fix Tax ambiguity: Since it is not clear that order can be made only from 1 single region or multiple regions. In case of 1 single region, associate order to region and include region.tax in the calculations below.
  end

  def serialized
    order_items.present? ? serializable_hash(methods: :included_order_items) : serializable_hash
  end

  private

  def make_payment
    PaymentJob.set(wait_until: 1.minutes).perform_later(id)
  end

  # TODO: below functions should be moved to app/serializers/order.rb

  def attributes
    {
      id: id,
      status: status,
      shipping_address: shipping_address,
      price: price.to_f,
      paid_at: paid_at
    }
  end

  def included_order_items
    order_items.includes(:product).map do |item|
      {
        id: item.id,
        product: {
          title: item.product.title,
          sku: item.product.sku,
          price: item.product.price
        }
      }
    end.to_a
  end
end
