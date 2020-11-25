class Comment < ApplicationRecord
  validates :comment_body, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
end
