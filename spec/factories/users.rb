FactoryBot.define do

  factory :user do
    name { "アドミニストレータ" }
    email { "admin_1@test.com" }
    password { "aaa" }
    password_confirmation { "aaa"}
    admin { true }
  end

  factory :user_b, class: User do
    name { "一般B" }
    email { "bbb2@test.com" }
    password { "aaa" }
    password_confirmation { "aaa" }
    admin { false }
  end

  factory :user_c, class: User do
    name { "一般C" }
    email { "ccc@test.com" }
    password { "aaa" }
    password_confirmation { "aaa" }
    admin { false }
  end

end
