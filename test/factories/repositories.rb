# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    full_name { 'github/github' }
    github_id { Faker::Number.number(digits: 10) }
    name { 'repo_js_valid' }
    language { 'javascript' }
    clone_url { 'http://github.git' }
    repo_created_at { Faker::Time.between_dates(from: 2.days.ago, to: Time.zone.now, period: :all) }
    repo_updated_at { Faker::Time.between_dates(from: 2.hours.ago, to: Time.zone.now, period: :all) }
  end
end
