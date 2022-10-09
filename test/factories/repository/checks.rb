# frozen_string_literal: true

FactoryBot.define do
  factory :repository_check, class: 'Repository::Check' do
    check_passed { 'false' }
  end
end
