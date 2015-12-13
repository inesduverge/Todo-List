class Tab < ActiveRecord::Base

  TITLE_SIZE = 10

  def self.find_all_from_user(user_id)
    select_query = "SELECT t.* FROM shares s, tabs t WHERE t.id = s.tab_id  AND s.user_id = '#{user_id}' ORDER BY t.created_at"
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
    insert_query = "INSERT INTO tabs (titulo, created_at, updated_at) values ('#{title}', '#{Time.now}', '#{Time.now}') RETURNING id" #retorna um duplo array ex: [["2"]]

    sql_connection.execute("BEGIN")
		tab_id = sql_connection.execute(insert_query)
    insert_in_shared_query = "INSERT INTO shares (user_id, tab_id) values ('#{user_id}', '#{tab_id.values.first.first}') RETURNING id"
    shared_id = sql_connection.execute(insert_in_shared_query)
    sql_connection.execute("COMMIT")
    return tab_id
	end

  def self.destroy(id)
    sql_connection = ActiveRecord::Base.connection

    # Checklist deletion
    checklist_items_deletion_query = "DELETE FROM checklist_items c WHERE c.checklist_id = (SELECT t.id FROM checklists t WHERE t.tab_id = '#{id}')"
    checklist_deletion_query = "DELETE FROM checklists WHERE tab_id = '#{id}'"

    # Noted deletion
    notes_deletion_query = "DELETE FROM notes WHERE notes.tab_id = '#{id}'"

    # Pointlists deletion
    pointlist_items_deletion_query = "DELETE FROM pointlist_items pi WHERE pi.pointlist_id = (SELECT p.id FROM pointlists p WHERE p.tab_id = '#{id}')"
    pointlist_deletion_query = "DELETE FROM pointlists WHERE tab_id = '#{id}'"

    # Tab deletion
    share_deletion_query = "DELETE FROM shares WHERE tab_id = '#{id}'"
    deletion_query = "DELETE FROM tabs WHERE id='#{id}'"

    sql_connection.execute("BEGIN")
    sql_connection.execute(checklist_items_deletion_query)
    sql_connection.execute(checklist_deletion_query)
    sql_connection.execute(notes_deletion_query)
    sql_connection.execute(pointlist_items_deletion_query)
    sql_connection.execute(pointlist_deletion_query)
    sql_connection.execute(share_deletion_query)
    sql_connection.execute(deletion_query)
    sql_connection.execute("COMMIT")
  end

  def self.update(id, titulo)
    query = "UPDATE tabs SET titulo='#{titulo}' WHERE id='#{id}'"
    connection = ActiveRecord::Base.connection
    return connection.execute(query)
  end

  def self.validate_title(title)
    !title.empty? && title.size < TITLE_SIZE
  end

end
