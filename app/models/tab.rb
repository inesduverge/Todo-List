class Tab < ActiveRecord::Base

	def self.find_with_title(title)
		select_query = "SELECT * FROM tabs WHERE title = '#{title}'"
		result = Tab.find_by_sql(select_query)
		return result
	end

	def self.find_with_id(id)
		select_query = "SELECT * FROM tabs WHERE id = '#{id}'"
		result = Tab.find_by_sql(select_query)
		return result
	end

	def self.create(title)
		sql_connection = ActiveRecord::Base.connection
		insert_query = "INSERT INTO tabs (title) values ('#{title}') RETURNING id"
		id = sql_connection.execute(insert_query)
		return nil unless id
	end

end
