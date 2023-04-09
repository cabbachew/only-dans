class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @posts = Post.all
  end

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
