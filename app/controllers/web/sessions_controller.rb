# frozen_string_literal: true

module Web
  class SessionsController < ApplicationController
    def destroy
      sign_out
      flash[:notice] = t('.success')
      redirect_to root_path
    end
  end
end
