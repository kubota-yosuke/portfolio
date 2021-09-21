class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :matters, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :like_matters, through: :likes, source: :matter

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

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
