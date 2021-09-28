class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true

  enum status: { waiting: 0, working: 1, completed: 2 }

  class << self
    def localed_statuses    #enum日本語化メソッド
      statuses.keys.map do |s|
        [ApplicationController.helpers.t("status.task.#{s}"), s]
      end
    end
  end
end
