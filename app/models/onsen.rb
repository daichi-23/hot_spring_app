class Onsen < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :onsen_name, presence: true, length: {maximum: 50}
  validates :onsen_introduction, presence: true, length: {in: 5..30}
  validates :address, presence: true, length: {maximum: 100}

  mount_uploader :onsen_image, ImgUploader

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
