class RemoveIndexLinkToRepositories < ActiveRecord::Migration[6.1]
  def change
    remove_index :repositories, column: :full_name
  end
end
