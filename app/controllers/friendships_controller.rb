class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = Friendship.new(from_friend_id: current_user.id, to_friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Friend request sent."
      redirect_to profile_path(params[:friend_id])
    else
      flash[:alert] = "Unable to send friend request."
      redirect_to profile_path(params[:friend_id])
    end
  end

  def destroy
    @friendship = Friendship.find_by(from_friend_id: current_user.id, to_friend_id: params[:friend_id])
    @friendship.destroy
    flash[:notice] = "Cancelled friend request."
    redirect_to profile_path(params[:friend_id])
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
