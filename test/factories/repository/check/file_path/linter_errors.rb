# frozen_string_literal: true

FactoryBot.define do
  factory :repository_check_file_path_linter_error, class: 'Repository::Check::FilePath::LinterError' do
    message { 'MyString' }
    rule { 'MyString' }
    line_column { 'MyString' }
  end
end
