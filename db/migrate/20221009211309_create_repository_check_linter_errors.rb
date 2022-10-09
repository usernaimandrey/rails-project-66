class CreateRepositoryCheckLinterErrors < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_check_linter_errors do |t|
      t.string :message
      t.string :rule
      t.string :line_column
      t.string :file_path
      t.references :check, null: false, foreign_key: { to_table: :repository_checks, on_delete: :cascade }, index: true

      t.timestamps
    end
  end
end
