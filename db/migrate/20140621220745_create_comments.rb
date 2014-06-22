class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :content, null: false
    	t.integer :submitter_id, null: false
    	t.integer :post_id, null: false
    	t.integer :parent_comment_id
      t.timestamps
    end
  end
end
