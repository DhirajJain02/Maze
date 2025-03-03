# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout "auth"
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # after_action :assign_default_role, only: [ :create ]
  before_action :configure_permitted_parameters, if: :devise_controller?
  prepend_before_action :require_no_authentication, except: [ :create ]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    build_resource(sign_up_params)

    if resource.save
      flash[:notice] = "User created successfully!"

      # Prevent auto-login by NOT calling sign_up(resource_name, resource)
      role_param = params[:user][:role]
      if  current_user.present? && current_user.admin?
        resource.add_role(role_param)
        redirect_to after_sign_up_path_for(resource)
      else
        resource.add_role(:user)
        sign_in(resource)
        redirect_to posts_path
      end
    else
      Rails.logger.debug "USER CREATION FAILED: #{resource.errors.full_messages}"
      flash[:notice] = "User not created successfully!"
      flash[:alert] = resource.errors.full_messages.join(", ")
      if  current_user.present? && current_user.admin?
        redirect_to request.referer
      else
        redirect_to posts_path
      end
    end
  end

  # POST /resource

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :phone_number, :avatar ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :phone_number, :avatar ])
  end

  # def assign_default_role
  #   if current_user.present? && current_user.admin?
  #     resource.add_role(resource.role)
  #   else
  #     resource.add_role(:user) if resource.persisted?
  #   end
  # end

  def after_sign_up_path_for(_resource)
    admin_access_path
  end


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
