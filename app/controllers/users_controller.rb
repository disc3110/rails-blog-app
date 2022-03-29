class UsersController < ApplicationController
  def index
   @shown_users = User.take(3)
  end

  def show
   @shown_user = User.find(params[:id])
   @recent_posts = @shown_user.three_recent_posts
  end
end
