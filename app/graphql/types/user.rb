module Types
  class User < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :bio, String, null: true
    field :email, String, null: false
    field :tweets, [Types::Tweet], null: true
    field :liked_tweets, [Types::Tweet], null: true
  end
end