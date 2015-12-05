class CreateShareTable < ActiveRecord::Migration
  def change
    create_table :share_tables do |t|
    	t.integer :user_id
    	t.integer :tab_id
    end
  end
end
