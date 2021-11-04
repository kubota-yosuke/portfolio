class Matter < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  has_many :contracts, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :users, through: :contracts

  def user_belonging?(user)
    users.include?(user)
  end
end
