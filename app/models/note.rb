class Note < ActiveRecord::Base

  def self.find_by_id(note_id)
    select_query = "SELECT * FROM notes WHERE id = '#{note_id}'"
    return Note.find_by_sql(select_query).first
  end

  def self.find_all(tab_id)
    select_query = "SELECT * FROM notes WHERE tab_id = '#{tab_id}'"
    return Note.find_by_sql(select_query)
  end

  def self.create(tab_id, title, description)
    sql_connection = ActiveRecord::Base.connection
    insertion_query = "INSERT INTO notes (tab_id, title, description, updated_at, created_at) values ('#{tab_id}', '#{title}', '#{description}', '#{Time.now}', '#{Time.now}') RETURNING id"

    id = sql_connection.execute(insertion_query)
    return id
  end

  def self.destroy(id)
    sql_connection = ActiveRecord::Base.connection

    deletion_query = "DELETE FROM notes WHERE id='#{id}'"
    sql_connection.execute(deletion_query)
  
  end
end
