class CartItem < ApplicationRecord
    validates :cart_id, uniqueness: { scope: :item_id }
end
