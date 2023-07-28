class Contact
  include ActiveModel::Model

  attr_accessor :name, :email, :message
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, {presence: true}
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX } }
  validates :message, {presence: true, length: { maximum: 100 }}
end
