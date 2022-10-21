# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM
  extend Enumerize

  validates :passed, presence: true

  enumerize :passed, in: %w[no_check true false], default: 'no_check'

  belongs_to :repository

  has_many :linter_error, dependent: :destroy

  aasm do
    state :checked, initial: true
    state :finished
    state :faled

    event :finish do
      transitions from: :checked, to: :finished
    end

    event :fail do
      transitions from: :checked, to: :faled
    end
  end
end
