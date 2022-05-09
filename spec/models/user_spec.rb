RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of("name") }
    it { should validate_presence_of("bio") }
    it { should validate_presence_of("email") }
  end

  describe 'associations' do
    it { should have_many(:tweets).dependent(:destroy) }
    it { should have_many(:likes) }
    it { should have_many(:liked_tweets).through(:likes).source(:tweet) }
  end
end