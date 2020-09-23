FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Title #{n}" }
    content { 'Content' }
    status { 'todo' }
    deadline { Date.current.tomorrow }
    association :user
  end
end
