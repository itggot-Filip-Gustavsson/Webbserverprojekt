#require_relative: "orm.rb"

class App < Sinatra::Base

	enable :sessions

	get '/index' do 
		db = SQLite3::Database.open('db/login.sqlite')
		@user = session[:user]

		@adminpanel = db.execute("SELECT id, username, permission FROM users")
		
		@userid = db.execute("SELECT id FROM users WHERE Username = ?", [@user])
		@display = db.execute("SELECT content, contentid FROM usercontent WHERE Userid = ?", [@userid])
		if !session[:user]
			redirect '/login'
		end
		slim :index
	end

	post '/index' do 
		@user = session[:user]
		content = params['content']
		db = SQLite3::Database.open('db/login.sqlite')
		@userid = db.execute("SELECT id FROM users WHERE Username = ?", [@user])
		db.execute("INSERT INTO usercontent(Userid, content) VALUES (?, ?) ", [@userid, content])

		redirect '/index'
	end	

	post '/remove' do
		contentid = params['remove']
		db = SQLite3::Database.open('db/login.sqlite')
		db.execute("DELETE FROM usercontent WHERE contentid = ?", [contentid])
		redirect '/index'
	end

	post '/removeuser' do
		userid = params['remove']
		db = SQLite3::Database.open('db/login.sqlite')
		db.execute("DELETE FROM users WHERE id = ?", [userid])
		db.execute("DELETE FROM usercontent WHERE Userid = ?", [userid])
		redirect '/index'
	end

	post '/share' do 


	end

	get '/login' do 
		
		@fail = session[:login_fail]
		slim :login
	end

	get '/register' do 
		@rpass = session[:pwr]
		slim :register
	end

	post '/register' do 
		username = params['username']
		password = params['password']
		rpassword = params['rpassword']

		@rpass = true

		if password != rpassword
			session[:pwr] = "Passwords does not match!"
			redirect '/register'
		else
		
			db = SQLite3::Database.open('db/login.sqlite')

			@existing_usernames = db.execute("SELECT Username FROM users")

			i = 0
			while i != @existing_usernames.length
				if @existing_usernames[i][0] == username
					i = @existing_usernames.length - 1
					puts "Username already exists"
					@exist_user = true
				elsif @existing_usernames[i] = nil 
					@exist_user = false
					i = @existing_usernames.length - 1
				else
					@exist_user = false
					puts "Username dosent exist"
				end
				i+=1
			end

			if @exist_user == false	
				hash = BCrypt::Password.create(password)
				db.execute("INSERT INTO users(Hash, Username, permission) VALUES (?, ?, ?) ", [hash, username, 0])	
				redirect '/login'
			elsif @exist_user == true
				redirect '/register'
			end
		end	
		
	end

	post '/login' do
		session.destroy 
		username = params['username']
		password = params['password']

		db = SQLite3::Database.open('db/login.sqlite')
		@existing_user = db.execute("SELECT Username, Hash FROM users WHERE Username = ?", [username])

		p @existing_user
		if @existing_user == nil || @existing_user.empty?
			session[:login_fail] = "Wrong username or password, Please try again"
			redirect '/login'
		elsif @existing_user[0][0] == username && BCrypt::Password.new(@existing_user[0][1]) == password
			session[:user] = @existing_user[0][0]
			@permission = db.execute('SELECT permission FROM users WHERE Username = ?', @existing_user[0][0])
			session[:adminlevel] = @permission.first[0]
			redirect '/index'
		else
			redirect '/error'
		end
		
	end

	post '/changepermission' do

		newpermission = params['simple'].to_i
		userid = params['value']
		p newpermission
		p userid

		redirect '/index'
	end

	post '/logout' do 
		session.destroy
		redirect '/login'
	end

	

end