class Spot < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  
  has_attached_file :image, 
                    :storage => :s3,
                    :s3_host_name   => 's3-ap-northeast-1.amazonaws.com',
                    :s3_permissions => "private",
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :s3_region      => ENV['AWS_REGION'],
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  def s3_credentials
    {:bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
  end

  scope :get_area, -> (area) {
    where( 'city = ?', "#{area}" ) 
  }
  scope :get_category, -> (category) {
    where( 'category = ?', "#{category}" ) 
  }
  scope :get_keyword, -> (keyword) {
    where( 'name LIKE(?) OR content LIKE(?) OR address LIKE(?)', "%#{keyword}%",  "%#{keyword}%",  "%#{keyword}%" ) 
  }

end
