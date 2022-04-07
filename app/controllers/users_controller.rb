class UsersController < ApplicationController
  def index
    @shown_users = User.order(created_at: :desc).limit(5)
  end

  def show
    @shown_user = User.find(params[:id])
    @recent_posts = @shown_user.three_recent_posts
  end

  def create
  end
end
