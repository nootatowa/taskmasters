class Card < ApplicationRecord
  belongs_to :task
  validates :title, length: { in: 1..255 }
  validates :memo,  length: { maximum: 1000 }

def written_by?(current_customer)
    current_customer.id === task.customer.id
end

end
