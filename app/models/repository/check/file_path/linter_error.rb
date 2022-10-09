# frozen_string_literal: true

class Repository::Check::FilePath::LinterError < ApplicationRecord
  belongs_to :file_path
end
