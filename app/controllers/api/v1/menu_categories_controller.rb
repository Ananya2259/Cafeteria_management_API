class Api::V1::MenuCategoriesController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in

  def index
    if @condition
      menu_categories = MenuCategory.all.where(@condition)
    end
    unless @limit.blank?
      menu_categories = MenuCategory.all.limit(@limit).offset(@offset * @limit) unless @offset.blank?
    end
    render json: menu_categories.as_json(only: [:name, :status])
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
    @item.update(menu_category_params)
    render status: 200, json: {
      message: "update sucessfull",
    }
  end

  def show
    render json: @item.as_json(only: [:name, :status])
  end

  def menu_category_params
    params[:action] == "create" ? params[cname].permit(:name, :status).with_defaults(status: "active") : params[cname].permit(:name, :status)
  end
end
