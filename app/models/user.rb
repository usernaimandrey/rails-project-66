# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :email, :nickname, :token, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  has_many :repositories, dependent: :destroy
end
