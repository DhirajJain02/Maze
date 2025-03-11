class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [ :create, :show, :destroy ]

  def index
    @posts = Post.includes(:comments, :user, :likes).where("public = ? OR user_id = ?", true, current_user.id).order(created_at: :desc)
    if current_user.admin?
      @posts = Post.includes(:comments).order(created_at: :desc)# .page(params[:page]).per(10)
      @users = User.all.order(created_at: :desc)
    end
    respond_to do |format|
      format.json { render json: { message: "Success", posts: @posts }, status: :ok }
      format.html do
      end
    end
  end

  def create
    @user = current_user
    @post = Post.new(
      user_id: @user.id,
      description: params[:description],
      public: params[:public]
    )
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new   # This is for the form in the show
    @likes = @post.likes
    respond_to do |format|
      format.json { render json: { message: "Success", post: @post }, status: :ok }
      format.html do
      end
    end
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

  def destroy
    @post.destroy
    respond_to do |format|
      format.json { render json: { message: "Success", data: "post deleted" }, status: :ok }
      format.html do
        redirect_to posts_path, notice: "Post was successfully destroyed."
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
