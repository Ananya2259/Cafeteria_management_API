class Api::V1::ApplicationController < ApplicationController
  before_action :build_object, only: [:create]
  before_action :display_object, :process_search, only: [:index]
  before_action :load_object, only: [:show, :destroy, :update]
  # before_action :update_object, only: [:update]
  PATH_MAP = {
    users: {
      index: ["name", "email"],
      create: [
        "name", "password", "email", "role",
      ],
      destroy: ["id"],
      update: ["name", "email", "password"],
    },
    orders: {
      index: ["user_id", "status", "address"],
    },
    order_items: {
      index: ["order_id", "user_id"],
    },
    menu_items: {
      index: ["menu_item_id", "menu_item_name"],
    },
    menu_categories: {
      index: ["name", "status"],
    },
  }

  def initialize
    @limit = 10
    @offset = 0
  end

  def build_object
    build_params = send("#{cname}_params")
    if params[:password]
      build_params = build_params.merge(password: params[:password])
    end
    @item = model.new(build_params)
  end

  def display_object
    unless params[:limit].nil? && params[:offset].nil?
      @limit = Integer(params[:limit])
      @offset = Integer(params[:offset])
    end
  end

  def process_search
    @condition = ""
    value = @searcherror = []
    key = ""
    allowed_field = PATH_MAP[controller_name.to_sym][params[:action].to_sym]
    search_keys = params.select { |k, v| allowed_field.include?(k) }
    search_keys.each do |k, v|
      key += "#{key == "" ? "" : " and  "} #{k} LIKE ?"
      value.append("%#{v}%")
    end
    @condition = key, *value
  end

  def load_object
    @item = model.find(params[:id])
  end

  def cname
    controller_name.singularize #user User
  end

  def mname
    controller_name.classify.constantize #users=>user=>User
  end

  def model
    cname.capitalize.constantize #User
  end
end
