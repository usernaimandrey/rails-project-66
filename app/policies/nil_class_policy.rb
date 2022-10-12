# frozen_string_literal: true

class NilClassPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotDefinedError, 'Cannot scope NilClass'
    end
  end

  def show?
    false
  end

  def create?
    false
  end
end
