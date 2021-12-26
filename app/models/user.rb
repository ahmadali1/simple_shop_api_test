class User < ApplicationRecord
  has_secure_password
  has_many :stores
  has_many :regions
  has_many :orders
end
