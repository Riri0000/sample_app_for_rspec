FactoryBot.define do
  factory :task do
    sequence(:title, "title_1")
    content { 'Content' }
    status { 'todo' }
    deadline { Date.current.tomorrow }
    association :user
  end
end
