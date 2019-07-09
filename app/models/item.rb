class Item < ApplicationRecord
  belongs_to :merchant

  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews

  def sort_reviews(direction, limit)
    self.reviews.order(rating: direction, created_at: :asc).limit(limit)
  end

  def average_rating
    self.reviews.average(:rating)
  end
end
