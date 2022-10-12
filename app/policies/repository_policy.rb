# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def show?
    author?
  end
end
