class Checklist < ActiveRecord::Base

  def self.find_by_id(checklist_id)
    select_query = "SELECT * FROM checklists WHERE id = '#{checklist_id}'"
    return Checklist.find_by_sql(select_query).first
  end

  def self.find_all(tab_id)
    select_query = "SELECT * FROM checklists WHERE tab_id = '#{tab_id}'"
    return Checklist.find_by_sql(select_query)
  end

  def self.create(tab_id, title)
    sql_connection = ActiveRecord::Base.connection
    insertion_query = "INSERT INTO checklists (tab_id, title, updated_at, created_at) values ('#{tab_id}', '#{title}', '#{Time.now}', '#{Time.now}') RETURNING id"

    id = sql_connection.execute(insertion_query)
    return id
  end

  def self.destroy(id)
    sql_connection = ActiveRecord::Base.connection
    items_deletion_query = "DELETE FROM checklist_items WHERE checklist_id='#{id}'"

    deletion_query = "DELETE FROM checklists WHERE id='#{id}'"

    sql_connection.execute("BEGIN")
    sql_connection.execute(items_deletion_query)
    sql_connection.execute(deletion_query)
    sql_connection.execute("COMMIT")
  end

end
