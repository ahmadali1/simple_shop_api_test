class Region < ApplicationRecord
  belongs_to :user
  has_many :stores

  validates :name, :title, :country, :currency, presence: true
  validates :title, uniqueness: { scope: :user_id }
end
