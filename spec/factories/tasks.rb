FactoryBot.define do
  factory :task do
    title { 'タイトル1' }
    content { 'コンテント1' }
    limit { '2030/03/30'}
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテント2' }
    limit { '2020/01/31'}
  end
end
