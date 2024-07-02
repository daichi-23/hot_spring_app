class Collection < ApplicationRecord
  belongs_to :user
  belongs_to :onsen

  validates :comment, length: {maximum: 300}
end
