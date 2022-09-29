# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    token { Faker::Internet.password }
    image_url { Faker::Internet.url }
  end
end
