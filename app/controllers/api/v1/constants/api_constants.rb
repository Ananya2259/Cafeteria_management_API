module Api::V1::ApiConstants
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

  }
end

# # user = ["email", "name"]
# # order = ["date", "user_id"]
# # menu_categories = ["name", "status"]
# # menu_items = ["name", "menu_category_id", "price", "description"]
