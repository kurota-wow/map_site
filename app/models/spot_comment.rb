class SpotComment < ApplicationRecord
  belongs_to :customer
  belongs_to :spot

  validates :content, presence: true, length: { minimum: 5, maximum: 140 }
end
