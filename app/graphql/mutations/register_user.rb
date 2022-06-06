module Mutations
  class RegisterUser < GraphQL::Schema::Mutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true
    
    field :success, Boolean, null: false
    field :errors, [String], null: false
    field :user, Types::User, null: true

    def resolve(**args)
      # tweet = Tweet.new(args)
      user = User.new(args.to_h)
      success = user.save

      {
        success: success,
        errors: user.errors.full_messages,
        user: success ? user : nil
      }
    end
  end
end