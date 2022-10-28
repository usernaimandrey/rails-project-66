class ChangeCheckPassedToRepositoryChecksToTypeBollean < ActiveRecord::Migration[6.1]
  def up
    change_column :repository_checks, :passed, :boolean
  end

  def down
    change_column :repository_checks, :passed, :string
  end
end
