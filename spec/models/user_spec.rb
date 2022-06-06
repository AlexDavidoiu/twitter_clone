RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of("name") }
    it { is_expected.to validate_presence_of("email") }
    it { is_expected.to validate_uniqueness_of("email") }
  end

  describe 'associations' do
    it { is_expected.to have_many(:tweets).dependent(:destroy) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liked_tweets).through(:likes).source(:tweet) }
  end
end