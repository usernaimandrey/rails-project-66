# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!
    after_action :verify_authorized, only: %i[index show]

    def index
      @repositories = current_user.repositories.includes(:checks).order(created_at: :desc)
      authorize @repositories[0]
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
      link = permitted_params[:link]
      @repository = CreateRepositoryService.call(link, current_user)

      if @repository.save
        redirect_to repositories_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:link)
    end
  end
end
