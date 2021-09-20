class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true
end
