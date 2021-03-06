class CartItem < ApplicationRecord
    validates :cart_id, uniqueness: { scope: :item_id }
    belongs_to :cart
    belongs_to :item
end
