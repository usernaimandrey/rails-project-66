# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'
require_relative '../app/helpers/application_helper'
require_relative '../app/lib/application_container'

WebMock.disable_net_connect!

OmniAuth.config.test_mode = true

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all

  setup do
    queue_adapter.perform_enqueued_jobs = true

    queue_adapter.perform_enqueued_at_jobs = true
  end

  def load_fixture(filename)
    File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
  end
end

class ActionDispatch::IntegrationTest
  include AuthConcern

  def sign_in(user, _options = {})
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: user.email,
        name: user.name,
        nickname: user.nickname,
        image: user.image_url
      },
      credentials: {
        token: user.token
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
  end
end
