class UserSerializer < ActiveModel::Serializer
  attributes :name, :bio, :email, :tweets

  has_many :tweets
end