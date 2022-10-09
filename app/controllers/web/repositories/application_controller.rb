# frozen_string_literal: true

module Web
  class Repositories::ApplicationController < ApplicationController
    before_action :authenticate_user!

    def resource_repo
      @resource_repo ||= current_user.repositories.find_by(id: params[:repository_id])
    end
  end
end
