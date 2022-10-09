# frozen_string_literal: true

FactoryBot.define do
  factory :repository_check_linter_error, class: 'Repository::Check::LinterError' do
    message { 'Parsing error: Unexpected token <' }
    rule { 'indent' }
    line_column { "#{Faker::Number.digit}:#{Faker::Number.digit}" }
    file_path { Faker::File.file_name(dir: 'path/to') }
  end
end
