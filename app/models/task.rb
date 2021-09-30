class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true

  scope :desc_sort, -> { order(created_at: :desc) }
  scope :word_search, -> (para){ where('task_name LIKE ?', "%#{(para)}%") }
  scope :status_search, -> (para){ where(status: para) }

  enum status: { waiting: 0, working: 1, completed: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }

  class << self
    def localed_statuses    #enum日本語化メソッド
      statuses.keys.map do |s|
        [ApplicationController.helpers.t("status.task.#{s}"), s]
      end
    end
  end
end
