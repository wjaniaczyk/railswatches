class Watch < ApplicationRecord
    enum category: { standard: 0, premium: 1, premium_plus: 2 }
    belongs_to :user

    scope :filter_by_name, -> (name) { where("name like ?", "#{name}%")}
    scope :filter_by_price_min, -> (price_min) { where("price >= ?", price_min)}
    scope :filter_by_price_max, -> (price_max) { where("price <= ?", price_max)}
    scope :filter_by_category, -> (category) { where category: category }
end
 