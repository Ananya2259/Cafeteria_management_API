class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user
      redirect_to main_index_path
    else
      render "home/index"
    end
  end
end
