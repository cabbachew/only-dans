class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true
  has_many :posts, dependent: :destroy

  # Friendships
  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'from_friend_id', dependent: :destroy
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'to_friend_id', dependent: :destroy

  # Friends
  has_many :to_friends, through: :sent_friendships, source: :to_friend
  has_many :from_friends, through: :received_friendships, source: :from_friend

  def full_name
    "#{first_name} #{last_name}"
  end

  def friends
    to_friends + from_friends
  end
end
