class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.string :titulo, null: false
      t.timestamps null: false
    end
  end
end
