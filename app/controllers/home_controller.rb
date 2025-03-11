class HomeController < ApplicationController
  layout "auth"

  skip_before_action :authenticate_user!, only: %i[landing]
  def landing
    respond_to do |format|
      format.json { render json: { status: "Success", message: "Landing Page" } }
      format.html
    end
  end
end
