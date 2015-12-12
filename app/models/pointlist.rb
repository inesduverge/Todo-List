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

  # TODO: Missing destroy method
end
