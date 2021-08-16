class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in
  skip_before_action :routes_manager, only: [:create]

  def show
    render json: @item.as_json(only: [:name, :email])
  end

  def index
    if @condition
      users = User.all.where(@condition)
    end
    unless @limit.blank?
      users = User.all.limit(@limit).offset(@offset * @limit) unless @offset.blank?
    end
    render json: users.as_json(only: [:name, :email])
  end

  def create
    if @item.save
      render json: @item
      head :no_content
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    respond_to do |format|
      @item.destroy
      format.json { head :no_content }
    end
  end

  def update
    @item.update(user_params)
    render status: 200, json: {
      message: "update sucessfull",
    }
  end

  def user_params
    params[:action] == "create" ? params[cname].permit(:name, :email, :password, :role) : params[cname].permit(:name, :email)
  end
end
