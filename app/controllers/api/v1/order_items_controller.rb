class Api::V1::OrderItemsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in

  def create
    respond_to do |format|
      if @item.save
        format.json { render json: @item }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    if @condition
      order_items = OrderItem.all.where(@condition)
    end
    unless @limit.blank?
      order_items = OrderItem.all.limit(@limit).offset(@offset * @limit) unless @offset.blank?
    end
    render json: order_items.as_json(only: [:menu_item_name, :menu_item_id, :price, :quantity, :order_id])
  end

  def order_items_params
    params[cname].permit(:order_id, :menu_item_name, :menu_item_id, :price, :quantity).with_defaults(menu_item_name: MenuItem.find(params[:menu_item_id]).name, price: MenuItem.find(params[:menu_item_id]).price)
  end
end
