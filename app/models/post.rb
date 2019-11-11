class Post < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true 
  belongs_to :user
end
