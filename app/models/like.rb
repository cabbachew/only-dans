class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  enums :state, [:neutral, :like, :dislike]
end