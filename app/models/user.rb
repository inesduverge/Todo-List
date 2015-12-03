class User < ActiveRecord::Base
	attr_accessor :password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email

	def self.authenticate(email, password)
    select_command = "SELECT * FROM users WHERE email = '#{email}'"
    user = User.find_by_sql(select_command).first

    user.password_salt
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		end
	end
end
