class RenameCheckPassedToRepositoryChecks < ActiveRecord::Migration[6.1]
  def up
    rename_column :repository_checks, :check_passed, :passed
  end

  def down
    rename_column :repository_checks, :passed, :check_passed
  end
end
