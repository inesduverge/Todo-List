class ChecklistItem < ActiveRecord::Base
  def self.find_by_checklist(checklist_id)
    select_query = "SELECT * FROM checklist_items WHERE checklist_id = '#{checklist_id}' ORDER BY created_at DESC"
    return ChecklistItem.find_by_sql(select_query)
  end

  def self.destroy(id)
    sql_connection = ActiveRecord::Base.connection
    destroy_query = "DELETE FROM checklist_items WHERE id='#{id}'"
    sql_connection.execute(destroy_query)
  end

  def self.update(checklist_item)
    boolean_values = ["FALSE", "TRUE"] 
    query = "UPDATE checklist_items SET "

    checklist_item.each do |k, v|
      if k != 'id'
        if k == 'state'
          query += "#{k}=#{boolean_values[v.to_i]}, "
        else
          query += "#{k}='#{v}', " 
        end
      end
    end

    query = query[0..query.size - 3]
    query += " WHERE id='#{checklist_item[:id]}' RETURNING id"

    connection = ActiveRecord::Base.connection
    return connection.execute(query)
  end

  def self.create(checklist_id, description)
    sql_connection = ActiveRecord::Base.connection
    insert_query = "INSERT INTO checklist_items (state, checklist_id, description, created_at, updated_at) values (false, '#{checklist_id}', '#{description}', '#{Time.now}', '#{Time.now}') RETURNING id"

    id = sql_connection.execute(insert_query)
  end
end
