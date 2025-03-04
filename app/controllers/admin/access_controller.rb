class Admin::AccessController < AdminController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: %i[edit destroy]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
    render :new # Explicitly render new.html.erb
  end

  def upload
    @user = User.all.order(created_at: :desc)
  end

  def import
    file = params[:file]

    if file.present?
      # Save the file to a persistent location (e.g., tmp/)
      saved_path = Rails.root.join("tmp", "#{SecureRandom.hex}_#{file.original_filename}")

      File.open(saved_path, "wb") { |f| f.write(file.read) }

      # Pass the saved file path to Sidekiq
      BulkUserImportJob.perform_later(saved_path.to_s)

      redirect_to admin_access_path, notice: "File is being processed."
    else
      redirect_to admin_access_path, alert: "Please upload a file."
    end
  end

  def edit
    @user.update(
      active: !@user.active
    )
      redirect_to admin_access_path, notice: "User successfully updated."
  end

  def destroy
    @user.destroy
    redirect_to admin_access_path, notice: "User successfully destroyed."
  end

  private

  def authorize_admin
    redirect_to root_path, notice: "Not authorized to enter!!!" unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
