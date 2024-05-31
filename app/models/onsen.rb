class Onsen < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user 

  validates :onsen_name, presence: true, length: {maximum: 50}
  validates :onsen_introduction, presence: true, length: {in: 5..300}
  validates :address, presence: true, length: {maximum: 100}
  validates :latitude, presence: true

  mount_uploader :onsen_image, ImgUploader

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
