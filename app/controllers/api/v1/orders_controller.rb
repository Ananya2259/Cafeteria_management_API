class Api::V1::OrdersController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in

  def index
    if @condition
      orders = Order.all.where(@condition)
    end
    unless @limit.blank?
      orders = Order.all.limit(@limit).offset(@offset * @limit) unless @offset.blank?
    end
    render json: orders.as_json(only: [:status, :user_id, :address])
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

  def update
    @item.update(order_params)
    render status: 200, json: {
      message: "update sucessfull",
    }
  end

  def show
    render json: @item.as_json(:status, :user_id, :address)
  end

  def order_params
    params[:action] == "create" ? params[cname].permit(:status, :user_id, :address).with_defaults(status: "pending", user_id: session[:current_user_id]) : params[:action].permit(:status, :address)
  end
end
