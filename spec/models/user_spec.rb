require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#full_name" do
    it "returns a user's full name as a string" do
      user = build(:user, first_name: "Daniel", last_name: "Doe")

      expect(user.full_name).to eq "Daniel Doe"
    end
  end

  describe "#friends" do
    it "returns all friends regardless of befriender" do
      dan1 = create(:user)
      dan2 = create(:user)
      dan3 = create(:user)

      friendship1 = Friendship.create(from_friend: dan1, to_friend: dan2)
      friendship2 = Friendship.create(from_friend: dan3, to_friend: dan1)

      expect(dan1.friends).to include(dan2, dan3)
    end
  end
end
