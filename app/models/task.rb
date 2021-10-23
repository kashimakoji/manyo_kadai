class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true

  scope :desc_sort, -> { order(created_at: :desc) }
  scope :word_search, -> (para){ where('task_name LIKE ?', "%#{(para)}%") }
              #@tasks = @tasks.  where('task_name LIKE ?', "%#{params[:search]}%")
  scope :status_search, -> (para){ where(status: para) }
  scope :label_search, -> (para){ where(labels: { id: (para) }) }

  enum status: { waiting: 0, working: 1, completed: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  # class << self
  #   def localed_statuses    #enum日本語化メソッド
  #     statuses.keys.map do |s|
  #       [ApplicationController.helpers.t("status.task.#{s}"), s]
  #     end
  #   end
  # end
end
