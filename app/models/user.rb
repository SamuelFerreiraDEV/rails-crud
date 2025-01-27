class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 4, maximum: 10 }
  validates :email, presence: true, Uniqueness: true
  validates :password, presence: true, length: { minimum: 4, maximum: 10 }
  has_many :posts, dependent: :destroy
end
