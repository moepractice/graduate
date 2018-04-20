class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.references :user, foreign_key: true
      t.string :image
      t.integer :blog_id
    end
  end
end
