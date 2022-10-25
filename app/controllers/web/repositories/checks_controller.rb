# frozen_string_literal: true

module Web
  class Repositories::ChecksController < Repositories::ApplicationController
    after_action :verify_authorized, only: %i[show create]
    def show
      @check = resource_repo.checks.includes(:linter_errors).find(params[:id])
      @errors = @check.linter_errors
      authorize @check
    end

    def create
      @check = resource_repo.checks.build
      authorize @check

      if @check.save
        flash[:notice] = t('.success')
        CheckLinterJob.perform_later(@check.id)
      else
        flash[:alert] = t('.fail')
      end
      redirect_to resource_repo
    end
  end
end
