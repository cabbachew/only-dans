class Friendship < ApplicationRecord
  belongs_to :from_friend, class_name: "User"
  belongs_to :to_friend, class_name: "User"

  scope :accepted, -> { where.not(accepted_at: nil) }
  scope :pending, -> { where(accepted_at: nil) }
end
