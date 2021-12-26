class Region < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: :user_id
  has_many :stores
  has_many :products

  validates :name, :title, :country, :currency, presence: true
  validates :title, uniqueness: { scope: :user_id }
end
