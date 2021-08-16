class Api::V1::MenuItemsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in

  def index
    if @condition
      menu_items = MenuItem.all.where(@condition)
    end
    unless @limit.blank?
      menu_items = MenuItem.all.limit(@limit).offset(@offset * @limit) unless @offset.blank?
    end
    render json: menu_items.as_json(only: [:name, :description, :price, :menu_category_id])
  end

  def create
    respond_to do |format|
      if @item.save
        format.json { render json: @item }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @item.destroy
      format.json { head :no_content }
    end
  end

  def update
    @item.update(menu_item_params)
    render status: 200, json: {
      message: "update sucessfull",
    }
  end

  def show
    render json: @item.as_json(only: [:name, :description, :price])
  end

  def menu_item_params
    params[:action] == "create" ? params[cname].permit(:menu_category_id, :name, :description, :price) : params[cname].permit(:name, :description, :price)
  end
end
