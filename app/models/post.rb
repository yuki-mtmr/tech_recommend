class Post < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true 
  belongs_to :user

  def self.search(search)
    return Post.all unless search
    Post.where('url LIKE(?)', "%#{search}%")
  end

  def scrape
    url = self.url
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, charset)
    return doc
  end


end
