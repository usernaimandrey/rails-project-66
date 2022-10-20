class AddLastCommitShaToRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    add_column :repository_checks, :last_commit_sha, :string
  end
end
