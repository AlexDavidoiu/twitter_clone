module Types
  class Query < GraphQL::Schema::Object
    field :working, Boolean, null: false

    field :users, [Types::User], null: false
    field :user, Types::User, null: false do
      argument :id, ID, required: true
    end

    field :tweets, [Types::Tweet], null: false
    field :tweet, Types::Tweet, null: false do
      argument :id, ID, required: true
    end

    field :likes, [Types::Like], null: false

    def working
      true
    end

    def users
      ::User.all
    end

    def user(**args)
      ::User.find(args[:id])
    end

    def tweets
      ::Tweet.all
    end

    def tweet(**args)
      ::Tweet.find(args[:id])
    end

    def likes
      ::Like.all
    end
  end
end