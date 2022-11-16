class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  # validates :name, presence: true
  # validates :address, presence: true
  # validates :category, presence: true

  validates :name, :address, :category, presence: true
  CATEGORIES = ["chinese", "italian", "japanese", "french", "belgian"]
  validates :category, inclusion: { in: CATEGORIES }
end
