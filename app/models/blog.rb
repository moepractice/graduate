class Blog < ApplicationRecord
  validates :title,    length: { in: 1..20 }
  validates :content,  length: { in: 1..255 } 
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  has_many :comments, dependent: :destroy
  has_many :content_users, through: :comments, source: :user
  
  belongs_to :user
  mount_uploader :image, ImageUploader
end
