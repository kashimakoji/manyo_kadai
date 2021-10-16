User.create!(
  # id: '1',
  name: 'admin',
  email: 'admin@admin.com',
  admin: true,
  password: 'aa',
  password_confirmation: 'aa',
)

# User.create!(
#   name: 'A',
#   email: 'aa@aa',
#   admin: false,
#   password: 'aa',
#   password_confirmation: 'aa',
# )

User.create!(
  name: 'B',
  email: 'bb@bb',
  admin: false,
  password: 'aa',
  password_confirmation: 'aa',
)

20.times do |n|
  task_name = Faker::Coffee.country
  content = Faker::Ancient.god
  end_time = Faker::Date.between(from: 90.days.ago, to: Date.today)

  User.all.each do |user|
    Task.create!(
      user_id: user.id,
      # user_id: '1',
      task_name: task_name,
      content: content,
      end_time: end_time,
    )
  end
end
