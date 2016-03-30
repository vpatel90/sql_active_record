class Reviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :rating
      t.text :body
      t.timestamps null: false
    end
  end
end
