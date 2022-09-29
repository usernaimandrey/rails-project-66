# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    link { 'github/github' }
    repo_name { 'java' }
    language { 'Java' }
    repo_created_at { Faker::Time.between_dates(from: 2.days.ago, to: Time.zone.now, period: :all) }
    repo_updated_at { Faker::Time.between_dates(from: 2.hours.ago, to: Time.zone.now, period: :all) }
  end
end
