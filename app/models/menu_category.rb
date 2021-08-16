class MenuCategory < ApplicationRecord
  has_many :menu_items, :dependent => :destroy
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :name, presence: true
  validates :status, presence: true
end
