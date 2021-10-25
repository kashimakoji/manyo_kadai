FactoryBot.define do
  factory :label do
    name { "label" }
  end

  factory :second_label, class: Label do
    name { "second_label" }
  end

  factory :third_label, class: Label do
    name { "third_label" }
  end

  factory :fourth_label, class: Label do
    name { "fourth_label" }
  end

  factory :fifth_label, class: Label do
    name { "fifth_label" }
  end
end
