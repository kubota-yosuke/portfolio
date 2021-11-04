class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :contracts, dependent: :destroy
  has_many :applies, dependent: :destroy

  has_many :matters, dependent: :destroy
  has_many :comments

  has_many :likes, dependent: :destroy
  has_many :like_matters, through: :likes, source: :matter

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

  has_one_attached :image

  enum user_type: { photomodel: 0, cameraman: 1}

  acts_as_followable
  acts_as_follower

  def like(matter)
    like_matters << matter
  end

  def unlike(matter)
    like_matters.destroy(matter)
  end

  def like?(matter)
    like_matters.include?(matter)
  end
end
