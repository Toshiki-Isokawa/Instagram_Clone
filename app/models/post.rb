class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  
  has_one_attached :image
end
