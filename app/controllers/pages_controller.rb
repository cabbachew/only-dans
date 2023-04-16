class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    end

    @users = User.all.order(first_name: :asc, last_name: :asc)
    @post = Post.new
    
    # Include user data to avoid N+1 queries
    if params[:filter]
      @posts = Post.includes(:user)
        .where(user_id: current_user.friends)
        .order("created_at DESC")
    else
      @posts = Post.includes(:user).order("created_at DESC")
    end
  end

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
