RSpec.describe 'Users API', type: :request do
  describe 'create' do
    subject(:api_response) do
      post "/api/tweets/#{tweet.id}/like", params: params
      response
    end

    let!(:tweet) { Tweet.create(content: "alex's tweet content", user_id: user_1.id) }
    let!(:user_1) { User.create(name: "alex", bio: "alex's bio", email: "alex@example.com") }
    let!(:user_2) { User.create(name: "oana", bio: "oana's bio", email: "oana@example.com") }
    
    let(:params) do
      {
        user_id: user_2.id,
        tweet_id: tweet.id
      }
    end

    specify do
      expect(JSON.parse(api_response.body)).to match(
        hash_including(
          "user_id" => user_2.id,
          "tweet_id" => tweet.id
        )
      )
    end

    specify { expect(api_response).to have_http_status(201) }
    specify { expect { api_response }.to change(Like, :count).by(1) }
  end

#   describe 'destroy' do
#     subject(:api_response) do
#       delete "/api/users/#{user.id}"
#       response
#     end
    
#     let!(:user) { User.create(name: "alex", bio: "alex's bio", email: "alex@example.com") }
    
#     specify { expect(api_response).to have_http_status(200) }
#     specify { expect { api_response }.to change(User, :count).by(-1) }
    
#     describe 'user not found' do
#       subject(:api_response) do
#         delete "/api/users/not_an_id"
#         response
#       end

#       specify { expect(api_response).to have_http_status(404) }
#       specify { expect { api_response }.not_to change(User, :count) }
#       specify { expect(JSON.parse(api_response.body)).to match(hash_including("errors" => ["User not found"])) }
#     end
#   end
end