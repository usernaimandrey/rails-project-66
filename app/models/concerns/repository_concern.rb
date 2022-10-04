# frozen_string_literal: true

module RepositoryConcern
  def links_list
    link_names.pluck(:name)
  end
end
