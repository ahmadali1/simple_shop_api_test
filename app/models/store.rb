class Store < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: :user_id
  belongs_to :region
  # has_many :products, through: :region # verify this

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
