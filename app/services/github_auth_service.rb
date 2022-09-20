# frozen_string_literal: true

class GithubAuthService
  class << self
    def call(auth)
      attr = {
        email: auth.info.email,
        nickname: auth.info.nickname,
        name: auth.info.name,
        image_url: auth.info.image,
        token: auth.credentials.token
      }

      user = User.find_or_initialize_by(email: attr[:email])
      user.update(attr.except(:email))
      user
    end
  end
end
