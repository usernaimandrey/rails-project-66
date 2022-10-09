# frozen_string_literal: true

FactoryBot.define do
  factory :repository_check_file_path, class: 'Repository::Check::FilePath' do
    path { Faker::File.file_name(dir: 'path/to') }
  end
end
