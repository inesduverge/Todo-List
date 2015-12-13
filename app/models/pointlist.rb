class Pointlist < ActiveRecord::Base

  def self.find_by_id(pointlist_id)
    select_query = "SELECT * FROM pointlists WHERE id = '#{pointlist_id}'"
    return PointList.find_by_sql(select_query).first
  end

  def self.find_all(tab_id)
    select_query = "SELECT * FROM pointlists WHERE tab_id = '#{tab_id}'"
    return Pointlist.find_by_sql(select_query)
  end

  def self.create(tab_id, title)
    sql_connection = ActiveRecord::Base.connection
    insertion_query = "INSERT INTO pointlists (tab_id, title, updated_at, created_at) values ('#{tab_id}', '#{title}', '#{Time.now}', '#{Time.now}') RETURNING id"

    id = sql_connection.execute(insertion_query)
    return id
  end

  def self.delete(pointlist_id)
    sql_connection = ActiveRecord::Base.connection
    items_deletion_query = "DELETE FROM pointlist_items pi WHERE pointlist_id = '#{pointlist_id}'"
    deletion_query = "DELETE FROM pointlists WHERE id = '#{pointlist_id}'"
    sql_connection.execute("BEGIN")
    sql_connection.execute(items_deletion_query)
    sql_connection.execute(deletion_query)
    sql_connection.execute("COMMIT")
  end
end
