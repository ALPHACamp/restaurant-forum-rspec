FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { "12345678" }
    intro { FFaker::Lorem.paragraph }
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

  factory :restaurant do
    sequence(:name) { |n| "restaurant#{n}" }
    opening_hours { FFaker::Time.datetime }
    tel { FFaker::PhoneNumber.short_phone_number }
    address { FFaker::Address.street_address }
    description { FFaker::Lorem.paragraph }
    category
  end

  factory :comment do
    content { FFaker::Lorem.sentence }
    user
    restaurant
  end
end
