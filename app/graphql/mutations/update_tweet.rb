module Mutations
  class UpdateTweet < GraphQL::Schema::Mutation
    argument :id, ID, required: true
    argument :content, String, required: true
    
    field :success, Boolean, null: false
    field :errors, [String], null: false
    field :tweet, Types::Tweet, null: true

    def resolve(**args)
      tweet = Tweet.find(args[:id])
      success = tweet.update(args.to_h)

      {
        success: success,
        errors: tweet.errors.full_messages,
        tweet: success ? tweet : nil
      }
    end
  end
end