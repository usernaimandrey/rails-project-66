class AddLastCommitUrlToRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    add_column :repository_checks, :last_commit_url, :string
  end
end
