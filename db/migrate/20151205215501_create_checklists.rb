class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :title, null: false
      t.integer :tab_id

      t.timestamps null: false
    end
  end
end
