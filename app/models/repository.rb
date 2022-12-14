# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  validates :github_id, presence: true, uniqueness: true

  enumerize :language, in: %i[javascript ruby]

  belongs_to :user

  has_many :checks, dependent: :destroy
end
