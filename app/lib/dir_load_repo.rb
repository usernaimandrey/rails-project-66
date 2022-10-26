# frozen_string_literal: true

module DirLoadRepo
  def path
    Rails.root.join(DIR_REPO)
  end
end
