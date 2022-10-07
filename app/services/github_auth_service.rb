# frozen_string_literal: true

class GithubAuthService
  class << self
    def call(auth)
      user = User.find_or_initialize_by(email: auth.info.email.downcase)
      user.nickname = auth.info.nickname
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.token = auth.credentials.token

      register_dependensy(user.token, user.id)

      user
    rescue StandardError
      User.new
    end

    private

    def register_dependensy(token, id)
      ApplicationContainer.register("octokit_#{id}".to_sym, Octokit::Client.new(access_token: token, auto_paginate: true))
    rescue Dry::Container::Error
      Rails.logger.debug 'Dpendency already registred'
    end
  end
end
