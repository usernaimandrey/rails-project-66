class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :name
      t.string :email, index: { unique: true }
      t.string :token
      t.string :image_url

      t.timestamps
    end
  end
end
