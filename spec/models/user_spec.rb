require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#full_name" do
    it "returns a user's full name as a string" do
      user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@doe.com",
      )

      expect(user.full_name).to eq "John Doe"
    end
  end
end
