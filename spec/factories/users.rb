FactoryBot.define do
  factory :user do
    name { "アドミニストレータ" }
    email { "admin@a.com" }
    password { "aaa" }
    #password_confirmation { "aaa"}
    admin { true }
  end
  factory :user2, class: User do
    name { "一般A" }
    email { "aa@a.com" }
    password { "aaa" }
    #password_confirmation { "aaa" }
    admin { false }
  end
  factory :user3, class: User do
    name { "一般B" }
    email { "bb@a.com" }
    password { "aaa" }
    #password_confirmation { "aaa" }
    admin { false }
  end

end
