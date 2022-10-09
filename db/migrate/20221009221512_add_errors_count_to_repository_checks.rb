class AddErrorsCountToRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    add_column :repository_checks, :errors_count, :integer
  end
end
