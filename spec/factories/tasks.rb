FactoryBot.define do
  factory :task do
    title { 'タイトル1' }
    content { 'コンテント1' }
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテント2' }
  end
end
