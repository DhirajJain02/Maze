class Admin::AccessController < AdminController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: %i[edit destroy]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
    render :new # Explicitly render create.html.erb
  end

  # def create
  #   @user = current_user
  #   @user = User.new(
  #     first_name: params[:first_name],
  #     last_name: params[:last_name],
  #     email: params[:email],
  #     password: params[:password]
  #   )
  #   if @user.save
  #     redirect_to admin_posts_path, notice: "Post was successfully created."
  #   else
  #     # render :index, status: :unprocessable_entity
  #     redirect_to admin_access_path, notice: "User successfully updated."
  #   end
  # end

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
