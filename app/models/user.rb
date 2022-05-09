class User < ApplicationRecord
  validates :name, presence: true
  validates :bio, presence: true
  validates :email, presence: true

  has_many :tweets, dependent: :destroy
  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet
end