class RenameStateToRepositoryChecks < ActiveRecord::Migration[6.1]
  def up
    rename_column :repository_checks, :state, :aasm_state
  end

  def down
    rename_column :repository_checks, :aasm_state, :state
  end
end
