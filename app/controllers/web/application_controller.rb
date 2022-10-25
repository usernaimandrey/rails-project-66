# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    around_action :switch_locale
    include AuthConcern
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_author

    # rescue_from ActiveRecord::RecordNotFound, with: :not_found

    # rescue_from ActionController::RoutingError, with: :not_found

    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale

      I18n.with_locale(locale, &action)
    end

    def default_url_options
      { locale: I18n.locale }
    end

    private

    def user_not_author(exception)
      policy_name = exception.policy.class.to_s.underscore
      flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

      redirect_to root_path
    end

    # def not_found
    #   flash[:alert] = t('.not_found')
    #   redirect_to not_found_errors_path
    # end
  end
end
