RSpec.describe Follow, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:follower).class_name("User") }
    it { is_expected.to belong_to(:followed_user).class_name("User") }
  end
end