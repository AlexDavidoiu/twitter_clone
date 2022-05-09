RSpec.describe 'Users API', type: :request do
  describe 'index' do
    subject(:api_response) do
      get "/api/users"
      response
    end

    specify { expect(api_response).to have_http_status(200) }
    specify { expect(JSON.parse(api_response.body).size).to eq(0) }

    context 'when content is present' do
      let!(:user) { User.create(name: "alex", bio: "alex's bio", email: "alex@example.com") }
      let!(:tweet) { Tweet.create(content: "alex's tweet content", user: user) }

      specify do
        expect(JSON.parse(api_response.body)).to match([
          hash_including(
            "id" => user.id,
            "name" => user.name,
            "bio" => user.bio,
            "email" => user.email,
            "tweets" => [hash_including(
              "id" => tweet.id,
              "content" => tweet.content
            )]
          )
        ])
      end
    end
  end

  describe 'show' do
    subject(:api_response) do
      get "/api/users/#{user.id}"
      response
    end

    specify { expect(api_response).to have_http_status(200) }

    let!(:user) { User.create(name: "Makar", bio: "Makar's bio", email: "makar@gmail.com") }
    let!(:tweet) { Tweet.create(content: "Makar's tweet content", user: user) }

    specify do
      expect(JSON.parse(api_response.body)).to match(
        hash_including(
          "id" => user.id,
          "name" => user.name,
          "bio" => user.bio,
          "email" => user.email,
          "tweets" => [hash_including(
            "id" => tweet.id,
            "content" => tweet.content
          )]
        )
      )
    end

    context "user not found" do
      subject(:api_response) do
        get "/api/users/not_an_id"
        response
      end

      specify { expect(api_response).to have_http_status(404) }
      specify { expect(JSON.parse(api_response.body)).to match(hash_including("errors" => ["User not found"]))}
    end
  end

  describe 'create' do
    subject(:api_response) do
      post "/api/users", params: params
      response
    end

    let(:params) do
      {
        user: {
          name: "alex",
          bio: "alex's bio",
          email: "alex@example.com"
        }
      }
    end

    specify do
      expect(JSON.parse(api_response.body)).to match(
        hash_including(
          "name" => "alex",
          "bio" => "alex's bio",
          "email" => "alex@example.com"
        )
      )
    end

    specify { expect(api_response).to have_http_status(201) }
    specify { expect { api_response }.to change(User, :count).by(1) }

    describe "name not present" do
      let(:params) do
        {
          user: {
            bio: "alex's bio",
            email: "alex@example.com"
          }
        }
      end

      specify { expect(api_response).to have_http_status(422) }
      specify { expect { api_response }.not_to change(User, :count) }
      specify { expect(JSON.parse(api_response.body)).to match("errors" => ["Name can't be blank"]) }
    end

    describe "bio not present" do
      let(:params) do
        {
          user: {
            name: "alex",
            email: "alex@example.com"
          }
        }
      end

      specify { expect(api_response).to have_http_status(422) }
      specify { expect { api_response }.not_to change(User, :count) }
      specify { expect(JSON.parse(api_response.body)).to match("errors" => ["Bio can't be blank"]) }
    end

    describe "email not present" do
      let(:params) do
        {
          user: {
            name: "alex",
            bio: "alex's bio"
          }
        }
      end

      specify { expect(api_response).to have_http_status(422) }
      specify { expect { api_response }.not_to change(User, :count) }
      specify { expect(JSON.parse(api_response.body)).to match("errors" => ["Email can't be blank"]) }
    end
  end

  describe 'update' do
    subject(:api_response) do
      patch "/api/users/#{user.id}", params: params
      response
    end

    let(:params) do 
      {
        user: {
          name: "makar"
        }
      }
    end

    let!(:user) { User.create(name: "alex", bio: "alex's bio", email: "alex@example.com") }

    specify { expect(api_response).to have_http_status(200) }
    specify { expect { api_response }.to change { user.reload.name }.from("alex").to("makar")}

    context 'when user not found' do
      subject(:api_response) do
        patch "/api/users/not_an_id"
        response
      end

      specify { expect(api_response).to have_http_status(404) }
      specify { expect(JSON.parse(api_response.body)).to match(hash_including("errors" => ["User not found"])) }
    end

    context "when name not present" do
      let(:params) do
        {
          user: {
            name: ""
          }
        }
      end

      specify { expect(api_response).to have_http_status(422) }
      specify { expect { api_response }.not_to change { user.reload.name } }
      specify { expect(JSON.parse(api_response.body)).to match("errors" => ["Name can't be blank"]) }
    end
  end

  describe 'destroy' do
    subject(:api_response) do
      delete "/api/users/#{user.id}"
      response
    end
    
    let!(:user) { User.create(name: "alex", bio: "alex's bio", email: "alex@example.com") }
    
    specify { expect(api_response).to have_http_status(200) }
    specify { expect { api_response }.to change(User, :count).by(-1) }
    
    describe 'user not found' do
      subject(:api_response) do
        delete "/api/users/not_an_id"
        response
      end

      specify { expect(api_response).to have_http_status(404) }
      specify { expect { api_response }.not_to change(User, :count) }
      specify { expect(JSON.parse(api_response.body)).to match(hash_including("errors" => ["User not found"])) }
    end
  end
end
