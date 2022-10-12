# frozen_string_literal: true

module Web
  class Repositories::ChecksController < Repositories::ApplicationController
    after_action :verify_authorized, only: %i[show create]
    def show
      @check = resource_repo.checks.includes(:linter_error).find_by(id: params[:id])
      @errors = @check&.linter_error
      authorize @check
    end

    def create
      @check = resource_repo.checks.build
      authorize @check

      if @check.save
        flash[:notice] = t('.success')
        CheckLinterService.call(resource_repo, @check)
      else
        flash[:alert] = t('.fail')
      end
      redirect_to resource_repo
    end
  end
end
