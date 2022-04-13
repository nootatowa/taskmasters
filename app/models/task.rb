class Task < ApplicationRecord
  belongs_to :customer

  validates :title, length: { in: 1..255 }
end
