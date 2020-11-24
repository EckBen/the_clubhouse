class Post < ApplicationRecord
  validates :post_body, presence: true
  validates :post_title, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :user_id, presence: true
  
  
  belongs_to :user
  has_many :comments, dependent: :destroy
end
