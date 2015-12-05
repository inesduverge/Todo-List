class Share < ActiveRecord::Base
  attr_accessor :email

  def self.create(user_id, tab_id)
    sql_connection = ActiveRecord::Base.connection
    insert_query = "INSERT INTO shares (user_id, tab_id) values ('#{user_id}', '#{tab_id}') RETURNING id"

    tab_id = sql_connection.execute(insert_query)
    return tab_id
  end
end
