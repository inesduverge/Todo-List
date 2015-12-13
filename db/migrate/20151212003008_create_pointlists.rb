class CreatePointlists < ActiveRecord::Migration
  def change
    create_table :pointlists do |t|
      t.integer :tab_id, null: false
      t.string :title, null: false
      t.timestamps null: false
    end
  end
end
