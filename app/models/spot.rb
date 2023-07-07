class Spot < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  has_many :events

  scope :get_area, -> (area) {
    where( 'city = ?', "#{area}" ) 
  }
  scope :get_category, -> (category) {
    where( 'image = ?', "#{category}" ) 
  }
  scope :get_keyword, -> (keyword) {
    where( 'name LIKE(?) OR content LIKE(?) OR address LIKE(?)', "%#{keyword}%",  "%#{keyword}%",  "%#{keyword}%" ) 
  }

end
