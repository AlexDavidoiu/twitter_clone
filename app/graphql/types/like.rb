module Types
  class Like < GraphQL::Schema::Object
    field :id, ID, null: false
    field :user, Types::User, null: false
    field :tweet, Types::Tweet, null: false
  end
end