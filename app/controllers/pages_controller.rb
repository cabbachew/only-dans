class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    end

    @users = User.all.order(first_name: :asc, last_name: :asc)
    @posts = Post.includes(:user).order("created_at DESC")
    @post = Post.new
  end

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
