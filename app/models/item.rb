class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :orders
  attachment :image
  def self.search(search)
    if search
      Item.where(['name LIKE ?', "%#{search}%"])
    else
      Item.all
    end
  end
end
