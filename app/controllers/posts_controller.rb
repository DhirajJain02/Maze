class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    # @posts = Post.all.order(created_at: :desc)
    @posts = Post.includes(:comments).all.order(created_at: :desc)
    # puts "Posts: #{@posts}"
    # @comments = @post.comments.order(created_at: :desc)
    # @comment = Comment.new   # This is for the form in the show
  end

  def create
    @post = Post.new(
      title: params[:title],
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
  end

  def edit
  end

  def update
    if @post.update(
      title: params[:title],
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
    redirect_to posts_path, notice: "Post was successfully destroyed."
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :public)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
