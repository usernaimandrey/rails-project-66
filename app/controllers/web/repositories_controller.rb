# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!

    def index
      @repositories = current_user&.repositories
    end

    def show
      @repository = current_user.repositories.find_by(id: params[:id])
    end

    def new
      @repository = Repository.new
      @links = current_user.links_list
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
