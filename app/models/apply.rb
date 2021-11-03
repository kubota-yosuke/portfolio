class Apply < ApplicationRecord
  belongs_to :matter
  belongs_to :user

  validates :user_id, presence: true
  validates :matter_id, presence: true
  validates  :user_id, uniqueness: { scope: :matter_id}
  validates  :matter_id, uniqueness: { scope: :user_id}
end
