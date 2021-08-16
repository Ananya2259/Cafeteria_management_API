class User < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 4 }
  validates :email, { presence: true, uniqueness: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  has_many :cart_items, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :orders, :dependent => :destroy

  def to_user_details
    " Email:#{email} Name:#{name}"
  end

  def self.define_role(user_id)
    if User.find(user_id).role == "Admin" || User.find(user_id).role == "clerk"
      true
    else
      false
    end
  end
end
