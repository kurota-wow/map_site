class Bookmark < ApplicationRecord
  belongs_to :customer
  belongs_to :spot
  validates :customer_id, uniqueness: { scope: :spot_id }
end
