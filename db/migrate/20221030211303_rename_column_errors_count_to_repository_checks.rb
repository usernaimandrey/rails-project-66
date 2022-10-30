class RenameColumnErrorsCountToRepositoryChecks < ActiveRecord::Migration[6.1]
  def up
    rename_column :repository_checks, :errors_count, :count_errors
  end

  def down
    rename_column :repository_checks, :count_errors, :errors_count
  end
end
