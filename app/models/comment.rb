class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  validates :comment, presence: true
  validates :comment, length: { in: 1..140 }
  validates :content, presence: true
end
