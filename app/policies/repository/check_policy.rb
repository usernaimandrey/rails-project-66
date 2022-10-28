# frozen_string_literal: true

class Repository
  class CheckPolicy < ApplicationPolicy
    def create?
      author?
    end

    private

    def author?
      @record.repository.user == @user
    end
  end
end
