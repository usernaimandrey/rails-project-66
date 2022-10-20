class ChangeCheckPassedToRepositoryChecks < ActiveRecord::Migration[6.1]
  def up
    change_column :repository_checks, :check_passed, :string
  end

  def down
    change_column :repository_checks, :check_passed, :boolean
  end
end
