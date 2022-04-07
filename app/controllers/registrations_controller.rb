class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def create
    build_resource(sign_up_params)
    resource.skip_confirmation!
    resource.save
    sign_up(resource_name, resource) if resource.persisted?

    # render_jsonapi_response(resource)
    respond_to do |format|
      format.json { render json: resource }
    end
  end
end
