class CommentsController < ApplicationController
  def new; end

  def create
    @current_user = current_user
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @current_user.comments.new(comments_params)
    @comment.post = @post
    @comment.save
    redirect_to user_post_path(@user, @post)
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
