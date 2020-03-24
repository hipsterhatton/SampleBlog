class AddIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :blogs, :tags, using: :gin
  end
end
