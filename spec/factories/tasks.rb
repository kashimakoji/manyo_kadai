FactoryBot.define do
  factory :task do
    task_name { 'test_task_name_1' }
    content { 'test_content_1' }
  end
  factory :task_2, class: Task do
    task_name { 'test_task_name_2' }
    content { 'test_content_2' }
  end
  factory :task_3, class: Task do
    task_name { 'test_task_name_3' }
    content { 'test_content_3' }
  end
end
