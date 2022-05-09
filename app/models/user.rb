class User < ApplicationRecord
  validates :name, presence: true
  validates :bio, presence: true
  validates :email, presence: true

  has_many :tweets, dependent: :destroy
  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :follower
  
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"  
  has_many :followings, through: :given_follows, source: :followed_user
end