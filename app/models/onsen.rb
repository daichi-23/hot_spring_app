class Onsen < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :onsen_name, presence: true
  validates :onsen_introduction, presence: true
  validates :address, presence: true

  mount_uploader :onsen_image, ImgUploader
end
