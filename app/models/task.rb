class Task < ApplicationRecord
  belongs_to :customer
<<<<<<< HEAD
  has_many :task_comments, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :favorites, dependent: :destroy
=======

>>>>>>> ba90e9bb6192786418e88fafae891f37f3ada2c0
  validates :title, length: { in: 1..255 }

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
