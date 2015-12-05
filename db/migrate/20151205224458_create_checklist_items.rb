class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.integer :checklist_id
      t.boolean :state, null: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
