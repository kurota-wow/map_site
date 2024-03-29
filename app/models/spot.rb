class Spot < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  validate :verify_file_type
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :category, presence: true

  has_many :spot_comments, dependent: :destroy

  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_customers, through: :bookmarks, source: :customer

  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  scope :get_area, -> (area) {
    where(city: "#{area}") 
  }
  scope :get_category, -> (category) {
    where(category: "#{category}") 
  }
  scope :get_keyword, -> (keyword) {
    where( 'name LIKE(?) OR content LIKE(?) OR address LIKE(?)', "%#{keyword}%",  "%#{keyword}%",  "%#{keyword}%" ) 
  }

  private

  def verify_file_type
    return unless icon.attached?
    allowed_file_types = %w[image/jpg image/jpeg image/png image/webp]
    errors.add(:icon, 'only jpg, jpeg, png, webp') unless allowed_file_types.include?(icon.blob.content_type)
  end

end
