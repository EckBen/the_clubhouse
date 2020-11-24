class AddColumnsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    remove_column :comments, :post_id
  end
end
