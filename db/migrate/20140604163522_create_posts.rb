class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :content, null: false
      t.integer :sub_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :posts, :title
  end
end
