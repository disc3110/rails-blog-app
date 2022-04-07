class Api::CommentController < Api::BaseController
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @post = Post.includes(:comments).find(params[:post_id])
    @comments = @post.comments
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def create
    @current_user = current_user
    @post = Post.find(params[:post_id])
    @comment = @current_user.comments.new(comments_params)
    @comment.post = @post
    response = ''
    response = if @comment.save
                 'Comment was saved'
               else
                 'Comment was not saved'
               end
    respond_to do |format|
      format.json { render json: response }
    end
  end
end
