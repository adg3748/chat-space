FactoryGirl.define do

  namae = Faker::Name.name
  pass = Faker::Internet.password(8)
  num = Faker::Number.between(1, 100)

  factory :user do
    name namae
    email Faker::Internet.email
    password pass
    password_confirmation pass
  end

  factory :group do
    name namae
  end

  factory :message do
    content Faker::Lorem.words
    user_id num
    group_id num
  end

  factory :groups_users do
    user_id num
    group_id num
  end

end
