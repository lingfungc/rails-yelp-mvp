class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  # validates :name, presence: true
  # validates :address, presence: true
  # validates :category, presence: true

  CATEGORIES = ["chinese", "italian", "japanese", "french", "belgian"]
  validates :name, :address, :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  include PgSearch::Model
  pg_search_scope :search_by_name, against: :name
    # using: {
    #   tsearch: { prefix: true } # <-- now `superman batm` will return something!
    # }
end
