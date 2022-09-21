# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      user = GithubAuthService.call(auth)

      if user.save
        sign_in(user)
        redirect_to root_path, notice: t('.success', user: user.name)
      else
        flash[:alert] = t('.failure')
        redirect_to root_path
      end
    end

    private

    def auth
      request.env['omniauth.auth']
    end
  end
end
