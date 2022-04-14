class Task < ApplicationRecord
  belongs_to :customer
  has_many :task_comments, dependent: :destroy
  validates :title, length: { in: 1..255 }
end
