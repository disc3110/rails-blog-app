class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  private

  def respond_with(resource, _opts = {})
    respond_to do |format|
      format.json { render json: resource }
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
