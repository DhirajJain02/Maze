class Admin::ProfileController < AdminController
  before_action :authenticate_user!

  def index
    @user=current_user
  end

  def edit
  end

  def update
    if @post.update(
      description: params[:description],
      public: params[:public]
    )
      redirect_to posts_path, notice: "Post was successfully updated."
    else
      render :index, status: :unprocessable_entity
    end
  end
end
