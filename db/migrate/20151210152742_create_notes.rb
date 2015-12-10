class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :tab_id
	  t.string :title, null: false
      t.text :description, null:false
   
      t.timestamps null: false
    end
  end
end
