# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!

    def index
      @repositories = current_user.repositories.includes(:checks).order(created_at: :desc)
    end

    def show
      @repository = current_user.repositories.find(params[:id])

      @checks = @repository.checks.order(created_at: :desc)
    end

    def new
      @links = current_user.links
      @repository = Repository.new
    end

    def create
      github_id = permitted_params[:github_id]
      @repository = current_user.repositories.build(github_id: github_id)
      if @repository.save
        UpdateRepositoryJob.perform_later(@repository.id)
        redirect_to repositories_path, notice: t('.success')
      else
        flash[:alert] = @repository.errors.full_messages.join
        redirect_to new_repository_path(@repository)
      end
    end

    def clear_cache
      Rails.cache.delete(current_user.cache_key)
      flash[:notice] = t('.success')

      redirect_to new_repository_path
    end

    private

    def permitted_params
      params.require(:repository).permit(:github_id)
    end
  end
end
