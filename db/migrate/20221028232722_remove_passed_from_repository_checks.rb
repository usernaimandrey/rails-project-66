class RemovePassedFromRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    remove_column :repository_checks, :passed, :string
  end
end
