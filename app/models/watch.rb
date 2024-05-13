class Watch < ApplicationRecord
    enum category: { standard: 0, premium: 1, premium_plus: 2 }
    belongs_to :user

    scope :filter_by_name, -> (name) { where("lower(name) like ?", "#{name.downcase}%")}
    scope :filter_by_price_min, -> (price_min) { where("price >= ?", price_min)}
    scope :filter_by_price_max, -> (price_max) { where("price <= ?", price_max)}
    scope :filter_by_category, -> (category) { where category: category }

    def self.ransackable_attributes(auth_object = nil)
        ["category", "created_at", "description", "id", "id_value", "name", "photo_url", "price", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end
end
 