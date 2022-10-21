# frozen_string_literal: true

FactoryBot.define do
  factory :repository_check, class: 'Repository::Check' do
    passed { 'false' }
  end
end
