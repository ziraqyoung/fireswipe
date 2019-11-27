class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.references :category, index: true
      t.timestamps
    end
  end
end
