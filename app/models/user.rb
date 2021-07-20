class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter, :google_oauth2]
         
  require 'open-uri'
  
  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.password = Devise.friendly_token[0,20]
      avatar = open("#{auth.info.image}")
      user.avatar.attach(io: avatar, filename: "user_avatar.jpg")
      user.avatar = auth.info.image.gsub("picture","picture?type=large") if user.provider == "facebook"
    end
  end
  
  def self.find_for_google_oauth2(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = Devise.friendly_token[0,20]
      avatar = open("#{auth.info.image}")
      user.avatar.attach(io: avatar, filename: "user_avatar.jpg")
      user.avatar = auth.info.image.gsub("picture","picture?type=large") if user.provider == "facebook"
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end
  
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
