# frozen_string_literal: true

class Repository::Check::FilePath < ApplicationRecord
  validates :path, presence: true

  belongs_to :check

  has_many :linter_errors, dependent: :destroy
end
