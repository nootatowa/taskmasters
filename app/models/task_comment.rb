class TaskComment < ApplicationRecord
  belongs_to :customer
  belongs_to :task
end
