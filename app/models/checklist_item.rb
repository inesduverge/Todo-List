class ChecklistItem < ActiveRecord::Base

  def self.find_by_checklist(checklist_id)
    select_query = "SELECT * FROM checklist_items WHERE checklist_id = '#{checklist_id}' ORDER BY created_at DESC"
    return ChecklistItem.find_by_sql(select_query)
  end

  def self.find_all(tab_id)
    items_by_id = {}
    select_query = "SELECT ci.* FROM checklist_items ci, checklists c WHERE ci.checklist_id = c.id AND c.tab_id = '#{tab_id}' ORDER BY ci.created_at DESC "
    items = ChecklistItem.find_by_sql(select_query)
    items.each do |item|
      (items_by_id[item.checklist_id] ||= []) << item
    end
    return items_by_id
  end

  def self.destroy(id)
    sql_connection = ActiveRecord::Base.connection
    destroy_query = "DELETE FROM checklist_items WHERE id='#{id}'"
    sql_connection.execute(destroy_query)
  end

  def self.update(checklist_item)
    connection = ActiveRecord::Base.connection

    update_query_true = "UPDATE checklist_items SET description='#{checklist_item[:description]}', state=TRUE WHERE id='#{checklist_item[:id]}' RETURNING id"
    update_query_false = "UPDATE checklist_items SET description='#{checklist_item[:description]}', state=FALSE WHERE id='#{checklist_item[:id]}' RETURNING id"

    if checklist_item[:state] == '1'
      return connection.execute(update_query_true)
    else
      return connection.execute(update_query_false)
    end
  end

  def self.create(checklist_id, description)
    sql_connection = ActiveRecord::Base.connection
    insert_query = "INSERT INTO checklist_items (state, checklist_id, description, created_at, updated_at) values (false, '#{checklist_id}', '#{description}', '#{Time.now}', '#{Time.now}') RETURNING id"

    id = sql_connection.execute(insert_query)
  end

end
