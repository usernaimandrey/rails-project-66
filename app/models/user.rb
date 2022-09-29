# frozen_string_literal: true

class User < ApplicationRecord
  include RepositoryConcern

  before_save { self.email = email.downcase }

  validates :email, :nickname, :token, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  has_many :repositories, dependent: :destroy

  def links
    Rails.cache.fetch("#{cache_key_with_version}/links", expires_in: 1.hour) do
      collections_repositories_links(self)
    end
  end
end
