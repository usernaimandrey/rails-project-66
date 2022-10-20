class RenameRepoNameToRepositories < ActiveRecord::Migration[6.1]
  def up
    rename_column :repositories, :repo_name, :name
  end

  def down
    rename_column :repositories, :name, :repo_name
  end
end
