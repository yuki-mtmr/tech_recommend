class Post < ApplicationRecord
  require 'nokogiri'
  require 'open-uri'

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
 end
  

end
