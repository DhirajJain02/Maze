class Post < ApplicationRecord
  paginates_per 10
  has_many :comments, dependent: :destroy

  validates :title, :description, presence: true
end
