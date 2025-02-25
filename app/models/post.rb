class Post < ApplicationRecord
  paginates_per 10

  belongs_to :user, foreign_key: "user_id"
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :description, presence: true
end
