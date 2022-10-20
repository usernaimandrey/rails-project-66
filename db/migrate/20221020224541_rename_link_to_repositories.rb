class RenameLinkToRepositories < ActiveRecord::Migration[6.1]
  def up
    rename_column :repositories, :link, :full_name
  end

  def down
    rename_column :repositories, :full_name, :link
  end
end
