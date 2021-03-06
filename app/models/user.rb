class User < ActiveRecord::Base
	attr_accessor :password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email

  REGEX_EMAIL = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/

	def self.create(email, password)
	  # obtem a conexao com a base de dados
      sql_connection = ActiveRecord::Base.connection

      # encrypts the password
      passwords = encrypt_password(password)

      # the insert sql command
      insert_command = "INSERT INTO users (email, password_salt, password_hash, created_at, updated_at) values ('#{email}', '#{passwords[:password_salt]}', '#{passwords[:password_hash]}', '#{Time.now}', '#{Time.now}') RETURNING id"
      id = sql_connection.execute(insert_command)
      return id
    end
   
   	def self.find_with_email(email)
   	  select_command = "SELECT * FROM users WHERE email = '#{email}'"
   	  result = User.find_by_sql(select_command)
      return result.first
   	end

   	def self.find_with_id(id)
   	  select_query = "SELECT * FROM users WHERE id = '#{id}'"
   	  result = User.find_by_sql(select_query)
      return result.first
   	end

	def self.authenticate(email, password)
      user = self.find_with_email(email)

	  if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
	    user
	  end
	end

	def self.encrypt_password(password)
      if password.present?
      	password_salt = BCrypt::Engine.generate_salt
      	password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
      return { password_salt: password_salt, password_hash: password_hash }
    end

   def self.find_all_from_tab(tab_id)
    select_query = "SELECT u.* FROM shares s, users u WHERE u.id = s.user_id AND s.tab_id = '#{tab_id}'"
    self.find_by_sql(select_query)
   end

   def self.validate_email(email)
    email.present? && (email =~ REGEX_EMAIL)
   end
end
