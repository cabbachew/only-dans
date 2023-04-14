class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friendship = Friendship.new(from_friend_id: current_user.id, to_friend_id: params[:friend_id])
    if friendship.save
      flash[:notice] = "Friend request sent."
    else
      flash[:alert] = "Unable to send friend request."
    end
    redirect_to profile_path(params[:friend_id])
  end

  def update
    friendship = Friendship.find_by(from_friend_id: params[:friend_id], to_friend_id: current_user.id)
    if friendship.update(accepted_at: Time.current)
      flash[:notice] = "Friend request accepted."
    else
      flash[:alert] = "Unable to accept friend request."
    end
    redirect_to profile_path(params[:friend_id])
  end

  def destroy
    user = User.find(params[:friend_id])
    friendship_status = current_user.friendship_status(user)
    message = destroy_message(friendship_status)

    current_user.friendship(user).destroy
    flash[:notice] = message
    redirect_to profile_path(params[:friend_id])
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

  def destroy_message(status)
    case status
    when FriendshipStatus::REQUESTING
      "Friend request declined."
    when FriendshipStatus::REQUESTED
      "Friend request cancelled."
    when FriendshipStatus::FRIEND
      "Unfriended."
    end
  end
end
