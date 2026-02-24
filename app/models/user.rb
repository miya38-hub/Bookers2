class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: true,
            length: { in: 2..20 }
  validates :introduction,
            length: { maximum: 50 },
            allow_blank: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
