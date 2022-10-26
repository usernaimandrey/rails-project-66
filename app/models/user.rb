# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  has_many :repositories, dependent: :destroy

  def links
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      ApplicationContainer[:github_api].fetch_links_github(self)
    end
  end

  def cache_key
    "links_cache-#{id}"
  end
end
