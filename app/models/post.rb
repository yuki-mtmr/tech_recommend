class Post < ApplicationRecord
  validates :url, presence: true
end
