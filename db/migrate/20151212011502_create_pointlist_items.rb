class CreatePointlistItems < ActiveRecord::Migration
  def change
    create_table :pointlist_items do |t|
      t.integer :pointlist_id, null: false
      t.integer :parent_id, null: false
      t.integer :level, null: false
      t.string  :title, null: false

      t.timestamps null: false
    end
  end
end
