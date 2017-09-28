class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :bookmark, index: true, foreign_key: true
      t.references :user

      t.timestamps null: false
    end
    add_index :likes, :user
  end
end
