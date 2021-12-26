class Product < ApplicationRecord
  belongs_to :region
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  # TODO: validates :sku, uniqueness: true
end
