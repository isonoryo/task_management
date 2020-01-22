FactoryBot.define do
  factory :user do
    name { '１号' }
    email { 'test10@gmail.com' }
    password { '111111' }
    admin { false }
  end

  factory :second_user, class: User do
    name { '2号' }
    email { 'test2@gmail.com' }
    password { '222222' }
    admin { true }
    end

    factory :therd_user, class: User do
      name { '3号' }
      email { 'test3@gmail.com' }
      password { '333333' }
      admin { true }
      end

    factory :fors_user, class: User do
      name { '4号' }
      email { 'test4@gmail.com' }
      password { '444444' }
      admin { true }
      end

end
