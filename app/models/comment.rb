class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :comments, as: :commentable, dependent: :destroy
  # has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true

  def post
    if commentable_type == "Post"
      commentable
    else
      commentable.post
    end
  end

  # def parent
  #   if commentable_type == "Post"
  #     nil
  #   else
  #     commentable
  #   end
  # end
end
