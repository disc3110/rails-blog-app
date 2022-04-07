class CommentsController < ApplicationController
  def index
    # @user = User.find(params[:user_id])
    @post = Post.includes(:comments).find(params[:post_id])
    @comments = @post.comments
    p(params[:user_id], params[:post_id])
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def new; end

  def create
    # @current_user = current_user
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(comments_params)
    @comment.post = @post
    response = ''
    response = if @comment.save
                 # flash[:notice] = 'Post was successfully created'
                 'comment was saved'
               else
                 # flash[:alert] = @comment.errors.messages
                 'comment was not saved'
               end
    respond_to do |format|
      format.json { render json: response }
      # format.html { redirect_to user_post_path(@user, @post) }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    @comment.destroy
    flash[:notice] = 'Comment was deleted'
    redirect_to user_post_path(@post)
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
