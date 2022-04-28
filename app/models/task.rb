class Task < ApplicationRecord
  belongs_to :customer
  has_many :task_comments, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, length: { in: 1..255 }

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end