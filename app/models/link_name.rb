# frozen_string_literal: true

class LinkName < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :user
end
