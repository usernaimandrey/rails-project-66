class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.string :link, index: { unique: true }
      t.string :repo_name
      t.string :language
      t.string :repo_created_at
      t.string :repo_updated_at
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
