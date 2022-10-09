class CreateRepositoryCheckFilePaths < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_check_file_paths do |t|
      t.string :path
      t.references :check, null: false, foreign_key: { to_table: :repository_checks, on_delete: :cascade }, index: true

      t.timestamps
    end
  end
end
