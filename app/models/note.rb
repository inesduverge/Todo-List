class Note < ActiveRecord::Base

  TITLE_SIZE = 25

  def self.find_by_id(note_id)
    select_query = "SELECT * FROM notes WHERE id = '#{note_id}'"
    return Note.find_by_sql(select_query).first
  end

  def self.find_all(tab_id)
    select_query = "SELECT * FROM notes WHERE tab_id = '#{tab_id}'"
    return Note.find_by_sql(select_query)
  end

  def self.create(new_note)
    sql_connection = ActiveRecord::Base.connection
    insertion_query = "INSERT INTO notes (tab_id, title, description, updated_at, created_at) values ('#{new_note[:tab_id]}', '#{new_note[:title]}', '#{new_note[:description]}', '#{Time.now}', '#{Time.now}') RETURNING id"

    id = sql_connection.execute(insertion_query)
    return id
  end

  def self.update(note)
    sql_connection = ActiveRecord::Base.connection
    update_query = "UPDATE notes SET title='#{note[:title]}', description='#{note[:description]}', updated_at='#{Time.now}' WHERE id='#{note[:id]}'"

    return connection.execute(update_query)
  end

  def self.destroy(id)
    sql_connection = ActiveRecord::Base.connection

    deletion_query = "DELETE FROM notes WHERE id='#{id}'"
    sql_connection.execute(deletion_query)
  end

  def self.validate(note)
    !note[:title].empty? && note[:title].size < TITLE_SIZE && !note[:description].empty?
  end
end
