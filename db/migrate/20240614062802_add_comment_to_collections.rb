class AddCommentToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :comment, :text
  end
end
