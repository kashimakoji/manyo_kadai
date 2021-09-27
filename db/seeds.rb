200.times do |n|
  task_name = Faker::Coffee.country
  content = Faker::Ancient.god
  end_time = Faker::Date.between(from: 90.days.ago, to: Date.today)

  Task.create!(task_name: task_name,
               content: content,
               end_time: end_time,
               )
end
