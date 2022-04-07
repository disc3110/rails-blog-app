class Api::PostsController < Api::BaseController
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
end
