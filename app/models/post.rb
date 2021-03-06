class Post < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'

  before_save :scrape

  belongs_to :user
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :url, presence: true
  validates :url, uniqueness: true 
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  def self.search(search)
    return Post.all unless search
    Post.where('title LIKE(?)', "%#{search}%")
  end

  def scrape
    url = self.url
    charset = nil 
    html = open(url) do |f|
      charset = f.charset 
      f.read 
    end
    doc = Nokogiri::HTML.parse(html, charset)
    img = doc.css('//meta[property="og:image"]/@content').to_s
    if img.length > 255
      img = ''
    end
    title = doc.title.to_s
    description = doc.css('//meta[property="og:description"]/@content').to_s
    while description.length > 255 do
      description = description.chop
    end
    self.img = img
    self.title = title
    self.description = description
  end

end
