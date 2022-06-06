RSpec.describe 'Tweets API', type: :request do
  let(:user) { User.create(name: "alex", email: "alex@example.com", password: "alex_pass", password_confirmation: "alex_pass") }
  let(:tweet) { Tweet.create(content: "alex's first tweet", user_id: user.id) }

  describe 'index' do
    subject(:api_response) do
      get "/api/tweets", headers: { "Authorization": JsonWebToken.encode(user_id: user.id) }
      response
    end

    specify { expect(api_response).to have_http_status(200) }
    specify { expect(JSON.parse(api_response.body).size).to eq(0) }
  end

#   describe 'show' do
#     subject(:api_response) do
#       get "/api/tweets/#{tweet.id}"
#       response
#     end

#     specify { expect(api_response).to have_http_status(200) }

#     let!(:tweet) { Tweet.create(content: "Makar's tweet content", user: user) }
#     let!(:user) { User.create(name: "Makar", bio: "Makar's bio", email: "makar@gmail.com") }

#     specify do
#       expect(JSON.parse(api_response.body)).to match(
#         hash_including(
#           "id" => tweet.id,
#           "content" => tweet.content,
#           "user" => hash_including(
#             "id" => user.id,
#             "name" => user.name,
#             "bio" => user.bio,
#             "email" => user.email
#           )
#         )
#       )
#     end

#     context 'tweet not found' do
#       subject(:api_response) do
#         get "/api/tweets/not_an_id"
#         response
#       end

#       specify { expect(api_response).to have_http_status(404) }
#       specify { expect(JSON.parse(api_response.body)).to match(hash_including("errors" => ["Tweet not found"]))}
#     end
#   end

  describe 'create' do
    subject(:api_response) do
      post "/api/tweets", params: params, headers: { "Authorization": JsonWebToken.encode(user_id: user.id) }
      response
    end

    let(:params) do
      {
        tweet: {
          content: "alex's first tweet",
          user_id: user.id
        }
      }
    end

    specify do
      expect(JSON.parse(api_response.body)).to match(
        hash_including(
          "content" => "alex's first tweet",
          "user" => hash_including(
            "id" => user.id
          )
        )
      )
    end

    specify { expect(api_response).to have_http_status(201) }
    specify { expect { api_response }.to change(Tweet, :count).by(1) }

    context 'when content is not present' do
      subject(:api_response) do
        post "/api/tweets", params: params
        response
      end

      let(:params) do
        {
          tweet: {
            user_id: user.id
          }
        }
      end

      specify { expect(api_response).to have_http_status(422) }
      specify { expect { api_response }.not_to change(Tweet, :count) }
      specify { expect(JSON.parse(api_response.body)).to match(hash_including(
        "errors" => ["Content can't be blank"]
      )) }
    end
  end

  describe 'update' do
    subject(:api_response) do
      patch "/api/tweets/#{tweet.id}", params: params, headers: { "Authorization": JsonWebToken.encode(user_id: user.id) }
      response
    end

    let(:params) do 
      {
        tweet: {
          content: "alex's first tweet updated"
        }
      }
    end


    specify { expect(api_response).to have_http_status(200) }
    specify { expect { api_response }.to change { tweet.reload.content }.from("alex's first tweet").to("alex's first tweet updated")}

    context 'when tweet not found' do
      subject(:api_response) do
        patch "/api/tweets/not_an_id", headers: { "Authorization": JsonWebToken.encode(user_id: user.id) }
        response
      end

      specify { expect(api_response).to have_http_status(404) }
      specify { expect(JSON.parse(api_response.body)).to match(hash_including("errors" => ["Tweet not found"])) }
    end

    context "when content not present" do
      let(:params) do
        {
          tweet: {
            content: ""
          }
        }
      end

      specify { expect(api_response).to have_http_status(422) }
      specify { expect { api_response }.not_to change { tweet.reload.content } }
      specify { expect(JSON.parse(api_response.body)).to match("errors" => ["Content can't be blank"]) }
    end
  end

  describe 'destroy' do
    subject(:api_response) do
      delete "/api/tweets/#{tweet.id}", headers: { "Authorization": JsonWebToken.encode(user_id: user.id) }
      response
    end
    
    specify { expect(api_response).to have_http_status(200) }
    # specify { expect { api_response }.to change(Tweet, :count).by(-1) }
    
    describe 'tweet not found' do
      subject(:api_response) do
        delete "/api/tweets/not_an_id", headers: { "Authorization": JsonWebToken.encode(user_id: user.id) }
        response
      end

      specify { expect(api_response).to have_http_status(404) }
      specify { expect { api_response }.not_to change(Tweet, :count) }
      specify { expect(JSON.parse(api_response.body)).to match(hash_including("errors" => ["Tweet not found"])) }
    end
  end
end
