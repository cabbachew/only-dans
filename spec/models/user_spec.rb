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

      create(:friendship, :accepted, from_friend: dan1, to_friend: dan2)
      create(:friendship, :accepted, from_friend: dan3, to_friend: dan1)

      expect(dan1.friends).to include(dan2, dan3)
    end

    it "does not return pending friendships" do
      dan1 = create(:user)
      dan2 = create(:user)

      create(:friendship, from_friend: dan1, to_friend: dan2)

      expect(dan1.friends).not_to include(dan2)
    end
  end

  describe "#friend?" do
    it "returns true if the users are friends" do
      dan1 = create(:user)
      dan2 = create(:user)

      create(:friendship, :accepted, from_friend: dan1, to_friend: dan2)

      expect(dan1.friend?(dan2)).to eq true
    end

    it "returns false if the users are not friends" do
      dan1 = create(:user)
      dan2 = create(:user)

      expect(dan1.friend?(dan2)).to eq false
    end
  end
end
