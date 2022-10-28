# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository

  has_many :linter_errors, dependent: :destroy

  aasm do
    state :created, initial: true
    state :checking
    state :finished
    state :failed

    event :check do
      transitions from: :created, to: :checking
    end

    event :finish do
      transitions from: :checking, to: :finished
    end

    event :fail do
      transitions from: :checking, to: :failed
    end
  end
end
