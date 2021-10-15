FactoryBot.define do
  factory :task do
    task_name { 'タスクネーム1' }
    content { 'コンテンツ1' }
    end_time { '2021/10/01' }
    status {2}
    priority {1}
    # user
  end
  factory :task2, class: Task do
    task_name { 'テストタスクネーム2' }
    content { 'テストコンテンツ2' }
    end_time { '2021/10/02' }
    status {2}
    priority {1}
    # user_a
  end
  factory :task3, class: Task do
    task_name { 'テストタスクネーム3' }
    content { 'テストコンテンツ3' }
    end_time { '2021/10/03' }
    status {1}
    priority {2}
    # user_b
  end
  factory :task4, class: Task do
    task_name { 'テストタスクネーム4' }
    content { 'テストコンテンツ4' }
    end_time { '2021/10/04' }
    status {0}
    priority {1}
    # user_a
  end
  factory :task5, class: Task do
    task_name { 'テストタスクネーム5' }
    content { 'テストコンテンツ5' }
    end_time { '2021/10/05' }
    status {0}
    priority {0}
    # user
  end
end
