class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :tweet_id, message: "has already liked the tweet" }
  # de testat

  belongs_to :user
  belongs_to :tweet
end