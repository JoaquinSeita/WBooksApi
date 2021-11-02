class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  has_many :rents, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :image_url, presence: true
end
