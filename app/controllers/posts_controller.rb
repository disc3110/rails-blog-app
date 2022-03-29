class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts_with_comments = @user.posts.all.map { |post| { post: post, comments: post.five_recent_comments } }
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.all
  end
end
