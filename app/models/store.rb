class Store < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: :user_id

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
