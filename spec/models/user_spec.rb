RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of("name") }
    it { should validate_presence_of("bio") }
    it { should validate_presence_of("email") }
  end

  describe 'associations' do
    it { should have_many(:tweets).dependent(:destroy) }
  end
end