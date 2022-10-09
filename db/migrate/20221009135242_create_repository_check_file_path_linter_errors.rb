class CreateRepositoryCheckFilePathLinterErrors < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_check_file_path_linter_errors do |t|
      t.string :message
      t.string :rule
      t.string :line_column
      t.references :file_path, null: false, foreign_key: { to_table: :repository_check_file_paths, on_delete: :cascade }, index: true

      t.timestamps
    end
  end
end
