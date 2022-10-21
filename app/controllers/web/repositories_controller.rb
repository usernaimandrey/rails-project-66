# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!
    after_action :verify_authorized, only: %i[show]

    def index
      @repositories = current_user.repositories.includes(:checks).order(created_at: :desc)
    end

    def show
      @repository = current_user.repositories.find_by(id: params[:id])
      @checks = @repository.checks.order(created_at: :desc)
      authorize @repository
    end

    def new
      @links = current_user.links
      @repository = Repository.new
    end

    def create
      full_name = permitted_params[:full_name]
      @repository = current_user&.repositories&.build(full_name: full_name)

      if @repository.save
        CreateRepositoryJob.perform_later(@repository.id, current_user.id)
        redirect_to repositories_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:full_name)
    end
  end
end
