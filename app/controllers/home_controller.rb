class HomeController < ApplicationController
  layout "auth"

  skip_before_action :authenticate_user!, only: %i[landing]
  def landing
  end
end
