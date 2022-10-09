# frozen_string_literal: true

module Web
  class Repositories::ChecksController < Repositories::ApplicationController
    def show
      @check = resource_repo.checks.includes(:linter_error).find_by(id: params[:id])
      @errors = @check&.linter_error
    end

    def create
      @check = resource_repo.checks.build

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
