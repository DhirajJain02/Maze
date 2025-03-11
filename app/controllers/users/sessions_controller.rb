# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "auth"
  skip_before_action :verify_authenticity_token, only: [ :create, :destroy ]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])

    if user && !user.active?
      respond_to do |format|
        format.json { render json: { error: "Your account is not active. Please contact support." }, status: :unauthorized }
        format.html do
          flash[:notice] = "Your account is not active. Please contact support."
          redirect_to new_user_session_path
        end
      end
    elsif user && user.valid_password?(params[:user][:password])
      respond_to do |format|
        format.json {
          render json: { message: "Signed in successfully.", user: current_user }, status: :ok
        }
        format.html { super }
      end
    else
      respond_to do |format|
        format.json {
          render json: { message: "Wrong Credentials" }, status: :unauthorized
        }
        format.html { super }
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
