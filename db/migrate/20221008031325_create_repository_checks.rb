class CreateRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_checks do |t|
      t.boolean :check_passed
      t.string :state
      t.references :repository, null: false, foreign_key: { to_table: :repositories, on_delete: :cascade }, index: true

      t.timestamps
    end
  end
end
