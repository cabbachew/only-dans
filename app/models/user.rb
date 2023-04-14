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

  def friendship_status(user)
    if user == self
      FriendshipStatus::INVALID
    elsif friend?(user)
      FriendshipStatus::FRIEND
    elsif requesting_friends.include?(user)
      FriendshipStatus::REQUESTING
    elsif requested_friends.include?(user)
      FriendshipStatus::REQUESTED
    else
      FriendshipStatus::NOT_FRIEND
    end
  end

  def friendship(user)
    sent_friendships.find_by(to_friend_id: user.id) || received_friendships.find_by(from_friend_id: user.id)
  end

  def friends
    # Match users from array of accepted friend requests
    User.where(id: sent_friendships.accepted.pluck(:to_friend_id) + received_friendships.accepted.pluck(:from_friend_id))
  end

  def requesting_friends
    User.where(id: received_friendships.pending.pluck(:from_friend_id))
  end

  def requested_friends
    User.where(id: sent_friendships.pending.pluck(:to_friend_id))
  end

  def friend?(user)
    friends.include?(user)
  end
end
