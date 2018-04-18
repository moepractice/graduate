class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :blog, index: true, foreign_key: true
      t.integer :blog_id
      t.text :content
      t.timestamps
    end
  end
end

