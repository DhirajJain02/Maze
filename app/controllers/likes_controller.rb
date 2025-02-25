class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    likeable = find_likeable
    likeable.likes.create(user: current_user)

    # respond_to do |format|
    #   format.html { redirect_back fallback_location: root_path, notice: "Liked" }
    #   format.turbo_stream
    # end
    redirect_to request.referer, notice: "Liked"
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy if like.user == current_user

    # respond_to do |format|
    #   format.html { redirect_back fallback_location: root_path, notice: "Unliked" }
    #   format.turbo_stream
    # end
    redirect_to request.referer, notice: "Unliked"
  end

  private
  def find_likeable
    params.each do |name, value|
      if name.end_with?("_id")
        return name.chomp("_id").classify.constantize.find(value)
      end
    end
  end
end
