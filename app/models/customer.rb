class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :spot_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_spots, through: :bookmarks, source: :spot

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
      customer.skip_confirmation!
    end
  end

  def own?(object)
    object.customer_id == id
  end

  def bookmark(spot)
    bookmark_spots << spot
  end

  def unbookmark(spot)
    bookmark_spots.destroy(spot)
  end

  def bookmark?(spot)
    bookmark_spots.include?(spot)
  end
end
