FactoryGirl.define do

  # variables
  namae = Faker::Name.name
  pass = Faker::Internet.password(8)

  factory :user do
    name namae
    email Faker::Internet.email
    password pass
    password_confirmation pass
  end

  factory :group do
    name Faker::Lorem.word
  end

  factory :message do
    content Faker::Lorem.word
    user_id Faker::Number.between(1, 100)
    group_id Faker::Number.between(1, 100)
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }

  end

end
