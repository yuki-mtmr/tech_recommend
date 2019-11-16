class Post < ApplicationRecord
  require 'nokogiri'
  require 'open-uri'

  before_save :scrape

  validates :url, presence: true
  validates :url, uniqueness: true 
  belongs_to :user

  def self.search(search)
    return Post.all unless search
    Post.where('url LIKE(?)', "%#{search}%")
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
    title = doc.title.to_s
    description = doc.css('//meta[property="og:description"]/@content').to_s
    self.img = img
    self.title = title
    self.description = description
  end

  

end
