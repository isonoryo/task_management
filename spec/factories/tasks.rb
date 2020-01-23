FactoryBot.define do
  factory :task, class: Task do
    title { 'タイトル1' }
    content { 'コンテント1' }
    limit { '2010/03/30'}
    priority { 2 }
    status { 1 }
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテント2' }
    limit { '2020/03/30'}
    priority { 3 }
    status { 1 }
  end
end
