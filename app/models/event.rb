class Event < ApplicationRecord
  validate :verify_file_type
  validates :name, presence: true
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [700, 500]
  end

  private

  def verify_file_type
    return unless image.attached?
    allowed_file_types = %w[image/jpg image/jpeg image/png]
    errors.add(:image, 'only jpg, jpeg, png') unless allowed_file_types.include?(image.blob.content_type)
  end
end
