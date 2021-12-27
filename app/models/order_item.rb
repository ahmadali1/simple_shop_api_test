class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: { greater_than: 0 }

  before_save :calculate_total_price

  def calculate_total_price
    self.total_price = product.price * quantity
  end
end
