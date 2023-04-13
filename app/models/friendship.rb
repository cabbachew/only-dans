class Friendship < ApplicationRecord
  belongs_to :from_friend, class_name: "User"
  belongs_to :to_friend, class_name: "User"
end
