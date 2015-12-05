class ChecklistItem < ActiveRecord::Base
  def self.find_by_checklist(checklist_id)
    select_query = "SELECT * FROM checklist_items WHERE checklist_id = '#{checklist_id}'"
    return ChecklistItem.find_by_sql(select_query)
  end

  def self.create(checklist_id, description)
    sql_connection = ActiveRecord::Base.connection
    insert_query = "INSERT INTO checklist_items (state, checklist_id, description, created_at, updated_at) values (false, '#{checklist_id}', '#{description}', '#{Time.now}', '#{Time.now}') RETURNING id"

    id = sql_connection.execute(insert_query)
  end
end
