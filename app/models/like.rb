class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  enum :state, [:neutral, :like, :dislike]
end