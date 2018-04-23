class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :blog, index: true, foreign_key: true
      t.integer :blog_id
      t.integer :user_id
      t.text :content
      t.text :image
      t.string :name
      t.timestamps
    end
  end
end

