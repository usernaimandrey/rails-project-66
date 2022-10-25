class AddDefaultBranchToRepositories < ActiveRecord::Migration[6.1]
  def change
    add_column :repositories, :default_branch, :string
  end
end
