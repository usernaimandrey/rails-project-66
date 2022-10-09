# frozen_string_literal: true

class User < ApplicationRecord
  include RepositoryConcern

  before_save { self.email = email.downcase }

  validates :email, :nickname, :token, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  has_many :repositories, dependent: :destroy

  def guest?
    false
  end

  def links
    client = ApplicationContainer[:fetch_links]
    Rails.cache.fetch('links_cache', expires_in: 1.hour) do
      client.fetch(self)
    end
  end
end
