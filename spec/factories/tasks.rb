FactoryBot.define do
  factory :task do
    task_name { 'テストタスクネーム_1' }
    content { 'テストコンテンツ_1' }
    end_time { '2021/10/01' }
  end
  factory :task_2, class: Task do
    task_name { 'テストタスクネーム_2' }
    content { 'テストコンテンツ_2' }
    end_time { '2021/10/02' }
  end
  factory :task_3, class: Task do
    task_name { 'テストタスクネーム_3' }
    content { 'テストコンテンツ_3' }
    end_time { '2021/10/03' }
  end
end
