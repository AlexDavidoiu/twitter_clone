module Types
  class Tweet < GraphQL::Schema::Object
    field :id, ID, null: false
    field :content, String, null: false
    field :user, Types::User, null: false
    field :liking_users, [Types::User], null: false
  end
end