class Tab < ActiveRecord::Base

  def self.find_all_from_user(user_id)
    select_query = "SELECT t.* FROM shares s, tabs t WHERE t.id = s.tab_id  AND s.user_id = '#{user_id}'"
    self.find_by_sql(select_query)
  end

	def self.find_with_title(title)
		select_query = "SELECT * FROM tabs WHERE title = '#{title}'"
		result = Tab.find_by_sql(select_query)
		return result
	end

	def self.find_with_id(id)
		select_query = "SELECT * FROM tabs WHERE id = '#{id}'"
		result = Tab.find_by_sql(select_query)
    return result.first
	end

	def self.create(title, user_id)
		sql_connection = ActiveRecord::Base.connection
    insert_query = "INSERT INTO tabs (titulo, created_at, updated_at) values ('#{title}', '#{Time.now}', '#{Time.now}') RETURNING id"

    sql_connection.execute("BEGIN")
		tab_id = sql_connection.execute(insert_query)
    insert_in_shared_query = "INSERT INTO shares (user_id, tab_id) values ('#{user_id}', '#{tab_id.values.first.first}') RETURNING id"
    shared_id = sql_connection.execute(insert_in_shared_query)
    sql_connection.execute("COMMIT")
    return tab_id
	end

end
