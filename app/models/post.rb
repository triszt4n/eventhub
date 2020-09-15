class Post < ApplicationRecord
  belongs_to :event

  validates :title, length: { in: 3..255 }
  validates :body, length: { maximum: 500 }
end
