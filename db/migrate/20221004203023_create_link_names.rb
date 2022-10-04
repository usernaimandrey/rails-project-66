class CreateLinkNames < ActiveRecord::Migration[6.1]
  def change
    create_table :link_names do |t|
      t.string :name, index: { unique: true }
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
