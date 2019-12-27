class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,omniauth_providers: [:facebook, :google_oauth2]

  has_many :posts, dependent: :destroy
  has_one :profiles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  mount_uploader :image, ImageUploader

    def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name:  auth.info.name,
        password: Devise.friendly_token[0, 20],
        image:  auth.info.image
      )
    end

    user
  end
end
