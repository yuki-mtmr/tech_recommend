class Post < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true 
  belongs_to :user

  def self.search(search)
    return Post.all unless search
    Post.where('url LIKE(?)', "%#{search}%")
  end
end
