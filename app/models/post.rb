class Post < ApplicationRecord
  validates :post_body, presence: true, length: { minimum: 60 }
  validates :post_title, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :user_id, presence: true
  
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
