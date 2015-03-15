class AddIndexForUrlToLinks < ActiveRecord::Migration
  def change
    add_index :links, :original_url, unique: true
  end
end
