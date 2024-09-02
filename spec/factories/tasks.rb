FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    priority { rand(1..5) }
    due_date { Faker::Date.between(from: Date.today, to: 1.year.from_now) }
    completed { [true, false].sample }
    user { create(:user) }
  end
end
