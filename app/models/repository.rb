# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  validates :link, presence: true, uniqueness: true

  enumerize :language, in: %i[JavaScript]

  belongs_to :user

  has_many :checks, class_name: 'Repository::Check', dependent: :destroy
end
