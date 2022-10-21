# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true

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

  def send_mail(check)
    CheckLinterStatusMailer.with(user: self, check: check).send_mail.deliver_later
  end
end
