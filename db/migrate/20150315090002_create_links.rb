class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :token
      t.text :original_url

      t.timestamps null: false
    end

    add_index :links, :token, unique: true
  end
end
