class User < ApplicationRecord
  rolify
  has_one_attached :avatar, dependent: :destroy
  validates :avatar, blob: { content_type: [ "image/png", "image/jpg", "image/jpeg" ] }
  validate :avatar_type
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "must be exactly 10 digits" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_commit :send_welcome_email, on: :create

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :trackable

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end

  private
  def avatar_type
    if avatar.attached? && !avatar.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:avatar, "must be a PNG, JPG, or JPEG")
    end
  end
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later

    admins=User.with_role(:admin)
    admins.each do |admin|
      AdminMailer.notify(admin, self).deliver_later
    end
  end
end
