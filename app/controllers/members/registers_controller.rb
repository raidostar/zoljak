class Members::RegistersController < Devise::RegistrationsController
  # before_action :authenticate_user!, :redirect_unless_admin, only: [:new, :create]
  # skip_before_action :require_no_authentication

  clear_respond_to
  respond_to :json
  
  def new
    @user = User.new()
  end

  def create
    super
  end

  def email_check
    puts params[:email]
    email = params[:email]
    users = User.where(email: email)
    if users.present?
      render json: true
    else
      render json: false
    end
  end

  private

  def redirect_unless_admin
    head :unauthorized unless current_user.try(:admin?)
  end

  def sign_up(_resource_name, _resource)
    true
  end
end
