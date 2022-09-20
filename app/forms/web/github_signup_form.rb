# frozen_string_literal: true

class Web::GithubSignupForm < User
  include ActiveFormModel

  permit :email, :nickname, :name, :image_url, :token

  def email=(email)
    if email.present?
      write_attribute(:email, email.downcase)
    else
      super
    end
  end
end
