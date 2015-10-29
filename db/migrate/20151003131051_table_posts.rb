class TablePosts < ActiveRecord::Migration
  def change
    create_table :posts
    add_column :posts, :content, :text
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
    add_column :posts, :user_id, :integer
    add_column :posts, :friend_id, :integer
    add_index :posts, :user_id
  end
end
