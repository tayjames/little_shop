class Merchant < ApplicationRecord
  has_many :items

  def count_of_items
    self.items.count
  end

  def average_item_price
    self.items.average(:price)
  end

  def distinct_cities
    self.items.joins(:orders).distinct("orders.city").order("orders.city").pluck("orders.city")
  end

  def has_orders?
    self.items.joins(:order_items).exists?
  end
end
