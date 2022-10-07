# frozen_string_literal: true

module Web
  class CachesController < ApplicationController
    def destroy
      Rails.cache.delete('links_cache')
      flash[:notice] = t('.success')
      redirect_to new_repository_path
    end
  end
end
