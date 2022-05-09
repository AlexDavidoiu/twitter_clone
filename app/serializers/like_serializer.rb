class LikeSerializer < ActiveModel::Serializer
  attributes :user_id, :tweet_id
end