class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }
  validates :email, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 30 }
  validates :password, length: { minimum: 1 }
end
