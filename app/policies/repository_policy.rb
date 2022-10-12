# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def index?
    author?
  end

  def show?
    author?
  end
end
