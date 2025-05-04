class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [ :create, :show, :destroy ]

  def index
    @posts = Post.includes(:comments, :user, :likes).where("public = ? OR user_id = ?", true, current_user.id).order(created_at: :desc)
    if current_user.admin?
      @posts = Post.includes(:comments).order(created_at: :desc)# .page(params[:page]).per( 10)
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
    description = params[:description]

    # Generate a text suggestion only if a description is provided.
    suggestion = TextSuggestionService.new(description).generate_suggestion if description.present?

    @post = Post.new(
      user_id: @user.id,
      description: description,
      public: params[:public],
      suggestion: suggestion
    )
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end
  def generate_text_suggestion
    # Expect the client to send a description prompt (use params[:description])
    if params[:description].present?
      suggestion = TextSuggestionService.new(params[:description]).generate_suggestion
      render json: { suggestion: suggestion }, status: :ok
    else
      render json: { error: "Description required" }, status: :unprocessable_entity
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

  # Dashboard action renders the user dashboard page.
  def dashboard
    @user = current_user
  end

  # Stats action returns aggregated stats as JSON.
  # You can call this endpoint via JavaScript to get the data for your charts.
  def stats
    @user = current_user
    stats = {
      posts_count: @user.posts.count,
      total_likes_received: @user.posts.joins(:likes).count,
      total_comments_received: @user.posts.joins(:comments).count,
      total_likes_given: @user.likes.count,
      total_comments_given: @user.comments.count,
      # Group by month—requires groupdate gem.
      posts_trend: @user.posts.group_by_month(:created_at, format: "%b %Y").count,
      likes_trend: @user.posts.joins(:likes).group_by_month("likes.created_at", format: "%b %Y").count,
      comments_trend: @user.posts.joins(:comments).group_by_month("comments.created_at", format: "%b %Y").count
    }
    render json: stats
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
