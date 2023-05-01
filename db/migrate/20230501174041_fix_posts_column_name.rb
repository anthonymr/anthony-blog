class FixPostsColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :commets_counter, :comments_counter
  end
end
