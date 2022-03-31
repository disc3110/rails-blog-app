class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts_with_comments = @user.posts.map { |post| { post: post, comments: post.five_recent_comments } }
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.all
  end

  def new
    @user = current_user
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    @post.commentsCounter = 0
    @post.likesCounter = 0

    if @post.save
      flash[:notice] = 'Post was successfully created'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:alert] = @post.errors.messages
      render :new, status: :unprocessable_entity
    end
  end

  def like
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @current_user = current_user
    @like = @current_user.likes.new(post_id: @post.id)
    @like.save
    redirect_to user_post_path(@user, @post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
