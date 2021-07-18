class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :avatar
  
  validates :avatar, presence: true
  
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  
  has_many :posts, dependent: :destroy
  has_many :comments
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :post
  
  def favorite(other_post)
    favorites.find_or_create_by(post_id: other_post.id)
  end
    
  def unfavorite(other_post)
    favorite = favorites.find_by(post_id: other_post.id)
    favorite.destroy if favorite
  end
  
  def like?(other_post)
    self.likes.include?(other_post)
  end
end
