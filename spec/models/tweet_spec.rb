RSpec.describe Tweet, type: :model do
  describe 'validations' do
    it { should validate_presence_of("content") }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end