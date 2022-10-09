class CreateRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_checks do |t|
      t.boolean :check_passed
      t.references :repository, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
