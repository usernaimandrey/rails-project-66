# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthConcern
    include Pundit::Authorization
    around_action :switch_locale

    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale

      I18n.with_locale(locale, &action)
    end

    def default_url_options
      { locale: I18n.locale }
    end
  end
end
