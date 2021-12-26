class Order < ApplicationRecord
  enum status: { unpaid: 0, paid: 1 } #TODO: cancelled

  belongs_to :customer, class_name: 'User', foreign_key: :user_id
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
end
