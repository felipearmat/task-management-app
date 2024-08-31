FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    priority { 1 }
    due_date { "2024-08-31" }
    completed { false }
    user { nil }
  end
end
