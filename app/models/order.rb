class Order < ApplicationRecord
  def self.view_count(order)
    counts = [
      [6, 'Half dozen'],
      [12, 'One dozen'],
      [24, 'Two dozens'],
      [36, 'Three dozens'],
      [nil, "Let's chat"]
    ]

    count = counts.find do |count|
      order.count == count.first
    end

    count.last
  end

  def self.view_is_delivery(order)
    if order.is_delivery
      'Yes'
    else
      'No'
    end
  end
end
