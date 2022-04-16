class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :task
  validates_uniqueness_of :task_id, scope: :customer_id
end
