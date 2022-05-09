RSpec.describe Tweet, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of("content") }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liking_users).through(:likes).source(:user) }
  end
end