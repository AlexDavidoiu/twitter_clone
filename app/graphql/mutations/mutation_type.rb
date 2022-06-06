module Mutations
  class MutationType < GraphQL::Schema::Object
    field :register_user, mutation: ::Mutations::RegisterUser
    field :update_tweet, mutation: ::Mutations::UpdateTweet
  end
end