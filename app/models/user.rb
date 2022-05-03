class User < ApplicationRecord
  validates :name, presence: true
  validates :bio, presence: true
  validates :email, presence: true

  has_many :tweets, dependent: :destroy
end