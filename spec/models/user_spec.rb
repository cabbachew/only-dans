require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#full_name" do
    it "returns a user's full name as a string" do
      user = build(:user, first_name: "Daniel", last_name: "Doe")

      expect(user.full_name).to eq "Daniel Doe"
    end
  end
end
