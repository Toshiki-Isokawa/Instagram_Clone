class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  
  has_one_attached :image
  
  has_many :comments, dependent: :destroy
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :post
  
  def like?(other_post)
    self.likes.include?(other_post)
  end
end
