class User < ApplicationRecord
  rolify
  has_one_attached :avatar
  validates :avatar, blob: { content_type: [ "image/png", "image/jpg", "image/jpeg" ] }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  # def active_for_authentication?
  #   super && active?
  # end
  # def inactive_message
  #   active? ? super : "Your account is not active. Please contact support."
  # end

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end
end
