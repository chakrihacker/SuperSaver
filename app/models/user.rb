class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable, :trackable

  has_many :deals
  has_many :messages, dependent: :destroy
  has_many :conversation_memberships, dependent: :destroy
  has_many :conversations, through: :conversation_memberships
end
