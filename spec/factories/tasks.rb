FactoryBot.define do
  factory :task do
    task_name { 'タスクネーム1' }
    content { 'コンテンツ1' }
    end_time { '2021/10/01' }
    status {2}
    priority {1}
    user
  end
  factory :task_2, class: Task do
    task_name { 'テストタスクネーム_2' }
    content { 'テストコンテンツ_2' }
    end_time { '2021/10/02' }
    status {2}
    priority {1}
    user2
  end
  factory :task_3, class: Task do
    task_name { 'テストタスクネーム_3' }
    content { 'テストコンテンツ_3' }
    end_time { '2021/10/03' }
    status {1}
    priority {2}
    user3
  end
  factory :task_4, class: Task do
    task_name { 'テストタスクネーム_4' }
    content { 'テストコンテンツ_4' }
    end_time { '2021/10/04' }
    status {0}
    priority {1}
    user2
  end
  factory :task_5, class: Task do
    task_name { 'テストタスクネーム_5' }
    content { 'テストコンテンツ_5' }
    end_time { '2021/10/05' }
    status {0}
    priority {0}
    user3
  end
end
