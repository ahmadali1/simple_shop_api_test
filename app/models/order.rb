class Order < ApplicationRecord
  enum status: { unpaid: 0, paid: 1 }

  belongs_to :customer, class_name: 'User', foreign_key: :user_id
end
