class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  # GET /profile
  # renders app/views/profile/index.html.erb (your “show” page)
  def index
  end

  # GET /profile/edit
  # renders app/views/profile/edit.html.erb
  def edit
  end

  # PATCH /profile
  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params
      .require(:user)
      .permit(:first_name, :last_name, :phone_number, :avatar)
  end
end
